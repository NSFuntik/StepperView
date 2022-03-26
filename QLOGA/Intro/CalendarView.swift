//
//  CalendarViewController.swift
//  Calendar
//
//  Created by Richard Topchii on 09.05.2021.
//

import BottomSheetSwiftUI
import CalendarKit
import EventKit
import EventKitUI
import SwiftUI
import UIKit

enum NewBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.2
    case bottom = 0.1
    case hidden = 0.0
}

struct CalendarPickerView: View {
    @State var bottomSheetPosition: NewBottomSheetPosition = .bottom

    var body: some View {
        CalendarPicker()
            .navigationTitle("Date & Time")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(.all, edges: .bottom)
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                         options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss,
                                   .backgroundBlur(effect: .extraLight), .cornerRadius(25),
                                   .shadow(color: .lightGray, radius: 3, x: 3, y: 3)],
                         headerContent: {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Day's workload")
                        .foregroundColor(Color.secondary.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 20, weight: .medium, design: .default))
                    Spacer()
                }
            }, mainContent: {
                HStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 10) {
                        Circle()
                            .frame(width: 16, height: 16, alignment: .top)
                            .foregroundColor(.Pink)
                            .shadow(color: .Pink, radius: 1, x: 0, y: 0)
                        Text("working hours")
                            .foregroundColor(.lightGray)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Circle()
                            .frame(width: 16, height: 16, alignment: .top)
                            .foregroundColor(Color(hex: "#D7FFEB"))
                            .shadow(color: Color(hex: "#D7FFEB") ?? .Green, radius: 1, x: 0, y: 0)
                        Text("current inquiry")
                            .foregroundColor(.lightGray)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Circle()
                            .frame(width: 16, height: 16, alignment: .top)
                            .foregroundColor(Color(hex: "#FFDDB6"))
                            .shadow(color: Color(hex: "#FFDDB6") ?? .orange, radius: 1, x: 0, y: 0)
                        Text("other orders")
                            .foregroundColor(.lightGray)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                }.padding([.horizontal, .top], 20)
                    .frame(height: 160, alignment: .top)
            })
            .toolbar {
                Button {
                    if bottomSheetPosition == .bottom {
                        bottomSheetPosition = .middle
                    } else {
                        bottomSheetPosition = .bottom
                    }
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.orange)
                }
            }
    }
}

struct CalendarPicker: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalendarViewController {
        let dayViewController = CalendarViewController()
        return dayViewController
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {}
}

struct CalendarPicker_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarPickerView()
        }
    }
}

final class CalendarViewController: DayViewController, EKEventEditViewDelegate {
    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"
        requestAccessToCalendar()
        subscribeToNotifications()
    }

    // MARK: - DayViewDataSource

    // This is the `DayViewDataSource` method that the client app has to implement in order to display events with CalendarKit
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        // The `date` always has it's Time components set to 00:00:00 of the day requested
        let startDate = date
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        // By adding one full `day` to the `startDate`, we're getting to the 00:00:00 of the *next* day
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!

        let predicate = eventStore.predicateForEvents(withStart: startDate, // Start of the current day
                                                      end: endDate, // Start of the next day
                                                      calendars: nil) // Search in all calendars

        let eventKitEvents = eventStore.events(matching: predicate) // All events happening on a given day
        let calendarKitEvents = eventKitEvents.map(EKWrapper.init)

        return calendarKitEvents
    }

    // MARK: - DayViewDelegate

    // MARK: Event Selection

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else {
            return
        }
        presentDetailViewForEvent(ckEvent.ekEvent)
    }

    // MARK: Event Editing

    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        // Cancel editing current event and start creating a new one
        endEventEditing()
        let newEKWrapper = createNewEvent(at: date)

        create(event: newEKWrapper, animated: true)
    }

    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? EKWrapper else {
            return
        }
        endEventEditing()
        beginEditing(event: descriptor,
                     animated: true)
    }

    override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        guard let editingEvent = event as? EKWrapper else {
            return
        }
        if let originalEvent = event.editedEvent {
            editingEvent.commitEditing()

            if originalEvent === editingEvent {
                // If editing event is the same as the original one, it has just been created.
                // Showing editing view controller
                do {
                    try eventStore.save(editingEvent.ekEvent,
                                        span: .thisEvent)
                } catch {
                    presentEditingViewForEvent(editingEvent.ekEvent)
                }
            } else {
                // If editing event is different from the original,
                // then it's pointing to the event already in the `eventStore`
                // Let's save changes to oriignal event to the `eventStore`
                try! eventStore.save(editingEvent.ekEvent,
                                     span: .thisEvent)
            }
        }
        reloadData()
    }

    override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        endEventEditing()
    }

    override func dayViewDidBeginDragging(dayView: DayView) {
        endEventEditing()
    }

    // MARK: - EKEventEditViewDelegate

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        endEventEditing()
        reloadData()
        controller.dismiss(animated: true, completion: nil)
    }

    // MARK: Private

    private var eventStore = EKEventStore()

    private func requestAccessToCalendar() {
        eventStore.requestAccess(to: .event) { [weak self] _, _ in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.initializeStore()
                self.subscribeToNotifications()
                self.reloadData()
            }
        }
    }

    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: eventStore)
    }

    private func initializeStore() {
        eventStore = EKEventStore()
    }

    @objc private func storeChanged(_ notification: Notification) {
        reloadData()
    }

    private func presentDetailViewForEvent(_ ekEvent: EKEvent) {
        let eventController = EKEventViewController()
        eventController.event = ekEvent
        eventController.allowsCalendarPreview = true
        eventController.allowsEditing = true
        navigationController?.pushViewController(eventController,
                                                 animated: true)
    }

    private func createNewEvent(at date: Date) -> EKWrapper {
        let newEKEvent = EKEvent(eventStore: eventStore)
        newEKEvent.calendar = eventStore.defaultCalendarForNewEvents

        var components = DateComponents()
        components.hour = 1
        let endDate = calendar.date(byAdding: components, to: date)

        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "New event"

        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
        return newEKWrapper
    }

    private func presentEditingViewForEvent(_ ekEvent: EKEvent) {
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = ekEvent
        eventEditViewController.eventStore = eventStore
        eventEditViewController.editViewDelegate = self
        present(eventEditViewController, animated: true, completion: nil)
    }
}

//
//  RequestTrackingView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/13/22.
//

import SwiftUI
import BottomSheetSwiftUI
import StepperView

enum TrackingInfoBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.2
    case bottom = 0.1
}

struct RequestTrackingView: View {
    @State var showInfo = false
    @State var infoBSPosition: TrackingInfoBottomSheetPosition = .bottom
    var body: some View {
        VStack {
            StepperView()
                .addSteps(steps)
                .addPitStops(pitStops)
                .indicators(indicators)
                .pitStopLineOptions(pitStopLineOptions)
                .spacing(90)
                .lineOptions(.custom(2.0, .lightGray))
                .padding(.horizontal, -30).padding(.trailing, -20)
            Spacer()
        }
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationTitle("Tracking")
        .navigationBarTitleDisplayMode(.inline)
        .bottomSheet(bottomSheetPosition: $infoBSPosition,
                     options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss,
                               .backgroundBlur(effect: .systemThinMaterialLight), .cornerRadius(25),
                               .shadow(color: .lightGray, radius: 1, x:1,  y: 1)],
         headerContent: {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text("ACTORS")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    Spacer()
                }
            }
        },
         mainContent: {
            HStack(alignment: .center) {
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Circle()
                        .frame(width: 16, height: 16, alignment: .top)
                        .foregroundColor(.Purple)
                        .shadow(color: .Purple, radius: 1, x: 0, y: 0)
                    Text("QLOGA")
                        .foregroundColor(.lightGray)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Circle()
                        .frame(width: 16, height: 16, alignment: .top)
                        .foregroundColor(.Green)
                        .shadow(color: .Green, radius: 1, x: 0, y: 0)
                    Text("Customer")
                        .foregroundColor(.lightGray)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(alignment: .center, spacing: 10) {
                    Circle()
                        .frame(width: 16, height: 16, alignment: .top)
                        .foregroundColor(.infoBlue)
                        .shadow(color: .infoBlue, radius: 1, x: 0, y: 0)
                    Text("Provider")
                        .foregroundColor(.lightGray)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                Spacer()
            }.padding([.horizontal], 10) .padding(.top, 30)
                .frame(height: 160, alignment: .top)
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if $infoBSPosition.wrappedValue == .bottom {
                        infoBSPosition = .middle
                    } else {
                        infoBSPosition = .bottom
                    }
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.Orange)
                }
            }
        })
    }

    let steps = [TextView(text:"Funds reservation is needed", font: .system(size: 17, weight: .medium, design: .rounded), color: .infoBlue,
                          subtitle: "(action: funds reservation is needed)", date: "25/1/2022 14:26"),
                 TextView(text:"Inquiry", font: .system(size: 17, weight: .medium, design: .rounded), subtitle: "(action: Update)", date: "25/1/2022 14:26"),
                 TextView(text:"Inquiry", font: .system(size: 17, weight: .medium, design: .rounded), subtitle: "(action: Send a direct inquiry)", date: "25/1/2022 14:26")
    ]

    let indicators = [
        StepperIndicationType.custom(Image(systemName:"checkmark.circle.fill").font(.largeTitle).foregroundColor(.infoBlue).eraseToAnyView()),
        StepperIndicationType.custom(Image(systemName:"checkmark.circle.fill").font(.largeTitle).foregroundColor(.Green).eraseToAnyView()),
        StepperIndicationType.custom(Image(systemName:"checkmark.circle.fill").font(.largeTitle).foregroundColor(.Green).eraseToAnyView())
    ]

    let pitStopLineOptions = [
        StepperLineOptions.custom(0, Color.lightGray),
        StepperLineOptions.custom(0, Color.lightGray),
        StepperLineOptions.custom(0, Color.lightGray)
    ]

    let pitStops = [
        TextView(text:RequestPitstops.p1, font: .system(size: 14, weight: .regular), color: .secondary).eraseToAnyView(),
        TextView(text:RequestPitstops.p2, font: .system(size: 14, weight: .regular), color: .secondary).eraseToAnyView(),
        TextView(text:RequestPitstops.p3, font: .system(size: 14, weight: .regular), color: .secondary).eraseToAnyView()
    ]

    struct RequestPitstops {
        static var p1 = ""
        static var p2 = "Note: Visit 3 is marked as \"Provider not arrived\" after 24 hours of no response from the provider. "
        static var p3 = "Note: Visit 3 is marked as \"Provider not arrived\" after 24 hours of no response from the provider. "
    }
}

struct RequestTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RequestTrackingView()
        }.previewDevice("iPhone 6s")
    }
}

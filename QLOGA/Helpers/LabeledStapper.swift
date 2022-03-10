//
//  LabeledStapper.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/7/22.
//

import SwiftUI

public struct LabeledStepper: View {

    public init(
        _ title: String,
        description: String = "",
        value: Binding<Int>,
        in range: ClosedRange<Int> = 0...Int.max,
        longPressInterval: Double = 0.3,
        repeatOnLongPress: Bool = true,
        style: Style = .init()
    ) {
        self.title = title
        self.description = description
        self._value = value
        self.range = range
        self.longPressInterval = longPressInterval
        self.repeatOnLongPress = repeatOnLongPress
    }

    @Binding public var value: Int

    public var title: String = ""
    public var description: String = ""
    public var range = 0...Int.max
    public var longPressInterval = 0.3
    public var repeatOnLongPress = true

    public var style = Style()

    @State private var timer: Timer?
    private var isPlusButtonDisabled: Bool { value >= range.upperBound }
    private var isMinusButtonDisabled: Bool { value <= range.lowerBound }

    /// Perform the math operation passed into the function on the `value` and `1` each time the internal timer runs
    private func onPress(_ isPressing: Bool, operation: @escaping (inout Int, Int) -> ()) {

        guard isPressing else { timer?.invalidate(); return }

        func action(_ timer: Timer?) {
            operation(&value, 1)
        }

        /// Instant action call for short press action
        action(timer)

        guard repeatOnLongPress else { return }

        timer = Timer.scheduledTimer(
            withTimeInterval: longPressInterval,
            repeats: true,
            block: action
        )
    }

    public var body: some View {

        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(style.titleColor)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                HStack(alignment: .bottom, spacing: 0) {
                    /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                    Button() { } label: { Image(systemName: "minus") }
                        .onLongPressGesture(
                            minimumDuration: 0
                        ) {} onPressingChanged: { onPress($0, operation: -=) }
                        .frame(width: style.buttonWidth, height: style.height)
                        .foregroundColor(
                            isMinusButtonDisabled
                            ? style.inactiveButtonColor
                            : style.activeButtonColor
                        )
                        .contentShape(Rectangle())

                    Divider()
                        .padding([.top, .bottom], 8)

                    Text("\(value)")
                        .foregroundColor(style.valueColor)
                        .frame(width: style.labelWidth, height: style.height)

                    Divider()
                        .padding([.top, .bottom], 8)
                        .zIndex(1)

                    /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                    Button() { } label: { Image(systemName: "plus") }
                        .onLongPressGesture(
                            minimumDuration: 0
                        ) {} onPressingChanged: { onPress($0, operation: +=) }
                        .frame(width: style.buttonWidth, height: style.height)
                        .foregroundColor(
                            .orange
                        )
                        .contentShape(Rectangle())
                }
                .background(.white)
                //                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .frame(height: style.height)
            }
            Spacer()
            VStack {
                Spacer()

                Text(description)
                    .foregroundColor(.black)
                    .font(Font.system(size: 17, weight: .semibold, design: .rounded))

            }
        }
        .lineLimit(1)
        
    }
}


// MARK: - Preview

struct LabeledStepper_Previews: PreviewProvider {

    static var previews: some View {
        LabeledStepper(
            "Title",
            description: "description",
            value: .constant(5)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}


public struct Style {

    public init(
        height: Double = 34.0,
        labelWidth: Double = 48.0,
        buttonWidth: Double = 48.0,
        buttonPadding: Double = 12.0,
        backgroundColor: Color = Color(.quaternarySystemFill),
        activeButtonColor: Color = Color(.label),
        inactiveButtonColor: Color = Color(.tertiaryLabel),
        titleColor: Color = Color(.label),
        descriptionColor: Color = Color(.secondaryLabel),
        valueColor: Color = Color(.label)
    ) {
        self.height = height
        self.labelWidth = labelWidth
        self.buttonWidth = buttonWidth
        self.buttonPadding = buttonPadding
        self.backgroundColor = backgroundColor
        self.activeButtonColor = activeButtonColor
        self.inactiveButtonColor = inactiveButtonColor
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.valueColor = valueColor
    }

    // TODO: Make these dynamic
    var height: Double
    var labelWidth: Double

    var buttonWidth: Double
    var buttonPadding: Double

    // MARK: - Colors
    var backgroundColor: Color
    var activeButtonColor: Color
    var inactiveButtonColor: Color

    var titleColor: Color
    var descriptionColor: Color
    var valueColor: Color
}

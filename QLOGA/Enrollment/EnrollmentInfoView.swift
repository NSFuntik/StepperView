//
//  EnrollmentInfoView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import StepperView
struct EnrollmentInfoView: View {
    @State var showInfo = false
    let steps = [
        HStack {
            Text("Verify Phone")
//                .multilineTextAlignment(.leading)
//                .font(Font.system(size: 17, weight: .regular, design: .rounded))
            Spacer()
        },
        HStack {
            Text("Confirm Addres ")
//                .multilineTextAlignment(.leading)
//                .font(Font.system(size: 17, weight: .regular, design: .rounded))
            Spacer()

        },
        HStack {
            Text("Identity verifications")
//                .multilineTextAlignment(.leading)
//                .font(Font.system(size: 17, weight: .regular, design: .rounded))
            Spacer()

        },
        HStack {
            Text("Accept T&C`s")
//                .multilineTextAlignment(.leading)
//                .font(Font.system(size: 17, weight: .regular, design: .rounded))
            Spacer()

        },
        HStack {
            Text("Customer ready to work!")
            Spacer()
        }]

    let indicationTypes = [StepperIndicationType
        .custom(NumberedCircleView(text: "●", width: 25, color: .lightGray)),
        .custom(NumberedCircleView(text: "●", width: 25, color: .lightGray)),
        .custom(NumberedCircleView(text: "●", width: 25, color: .lightGray)),
        .custom(NumberedCircleView(text: "●", width: 25, color: .lightGray)),
                           .custom(NumberedCircleView(text: "✓", width: 35, color: .Green))] 
    var body: some View {
        ZStack {
            HStack {
                DottedLine()
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                    .frame(width: 2, height: .infinity, alignment: .center)
                    .foregroundColor(Color.lightGray).padding(.horizontal, 14)
                Spacer()
            }
            VStack {
                HStack {
                    Image("Step").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 20)
                    Text("Verify Phone")
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                    }.padding(.vertical, 30)
                }
                Divider().padding(.leading, 50)
                HStack {
                    Image("Step").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 20)
                    Text("Confirm addres")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                    }.padding(.vertical, 30)
                }
                Divider().padding(.leading, 50)
                HStack {
                    Image("Step").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 20)
                    Text("Identity verifications")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                    }.padding(.vertical, 30)
                }
                Divider().padding(.leading, 50)
                HStack {
                    Image("Step").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 20)
                    Text("Accept T&C`s")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                    }.padding(.vertical, 30)
                }
                Divider().padding(.leading, 50)
                HStack {
                    Image("Step").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
                        .padding(.trailing, 20)
                    Text("Customer ready to work!")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                    }.padding(.vertical, 30)
                }
                Divider().padding(.leading, 50)


//                StepperView()
//                    .stepIndicatorMode(StepperMode.vertical)
//                    .addSteps(steps)
//                    .indicators(indicationTypes)
//                    .spacing(100)
//                    .lineOptions(StepperLineOptions.custom(
//                        reader.size.height * 0.8, Color.lightGray))
//                    .frame(height: reader.size.height, alignment: .center)
            }.background(Color.clear)


        }
    }
}

struct EnrollmentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        EnrollmentInfoView()
            .previewDevice("iPhone 6s")
    }
}
struct DottedLine: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

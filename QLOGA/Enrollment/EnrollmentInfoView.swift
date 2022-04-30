//
//  EnrollmentInfoView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//
import BottomSheetSwiftUI
import SwiftUI

enum InfoBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.5
    case hidden = 0.0
}

struct EnrollmentInfoView: View {
    @State var actorType: ActorsEnum
    @State var bottomSheetPosition: InfoBottomSheetPosition = .hidden
    @State var infoText: String = ""
    @State var showInfo = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    ZStack {
                        VStack {
                            Spacer()
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                                .shadow(radius: 0.5)
                                .frame(width: 0.5, height: 50, alignment: .bottom)
                                .foregroundColor(Color.lightGray)
                        }
                        Image("Step")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    .frame(maxWidth: 30, minHeight: 90,
                           idealHeight: 100, maxHeight: 130, alignment: .center)
                    .padding(.vertical, -20).padding(.trailing, 20)

                    Text("Verify Phone")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Your verified mobile number is mandatory and needed for maintaining communication with providers.")
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.lightGray)
                            .font(Font.system(size: 20, weight: .light, design: .rounded))
                    }
                }
                Divider().padding(.leading, 50)
                HStack {
                    ZStack {
                        DottedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                            .shadow(radius: 0.5)
                            .frame(width: 0.5, height: 115, alignment: .center)
                            .foregroundColor(Color.lightGray)
                        Image("Step")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                    }.frame(maxWidth: 30, minHeight: 90,
                            idealHeight: 120, maxHeight: 130, alignment: .center)
                    .padding(.vertical, -20).padding(.trailing, 20)
                    Text("Confirm addres")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Address verification is one of the ways we build trust between providers and customers. QLOGA’s services are provided at a customer’s home address, so our customers need to prove they live where they say they do. This also prevents any confusion over the address the service provider will need to travel too. Address verification is one of the ways we build trust between providers and customers. QLOGA’s services are provided at a customer’s home address, so our customers need to prove they live where they say they do. This also prevents any confusion over the address the service provider will need to travel too.")

                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.lightGray)
                            .font(Font.system(size: 20, weight: .light, design: .rounded))
                    }
                }
                Divider().padding(.leading, 50)
                HStack {
                    ZStack {
                        DottedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                            .shadow(radius: 0.5)
                            .frame(width: 0.5, height: 135, alignment: .center)
                            .foregroundColor(Color.lightGray)
                        Image("Step")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    .frame(maxWidth: 30, minHeight: 90,
                           idealHeight: 120, maxHeight: 130, alignment: .center)
                    .padding(.vertical, -5).padding(.trailing, 20)

                    Text("Identity verifications")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Identity verification is one of the ways we build trust between providers and customers. QLOGA’s services are provided at a customer’s home address, and our customers have a right to know the identity of the service provider coming to their home.")
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.lightGray)
                            .font(Font.system(size: 20, weight: .light, design: .rounded))
                    }
                }
                Divider().padding(.leading, 50)
                HStack {
                    ZStack {
                        DottedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                            .shadow(radius: 0.5)
                            .frame(width: 0.5, height: 125, alignment: .center)
                            .foregroundColor(Color.lightGray)
                        Image("Step")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    .frame(maxWidth: 30, minHeight: 90,
                           idealHeight: 120, maxHeight: 130, alignment: .center)
                    .padding(.vertical, -15).padding(.trailing, 20)
                    Text("Accept T&C`s")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "QLOGA Home Services Terms and Conditions for Providers")
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.lightGray)
                            .font(Font.system(size: 20, weight: .light, design: .rounded))
                    }
                }
                Divider().padding(.leading, 50)
                HStack {
                    ZStack {
                        VStack {
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                                .shadow(radius: 0.5)
                                .frame(width: 0.5, height: 55, alignment: .top)
                                .foregroundColor(Color.lightGray)
                            Spacer()
                        }

                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(.accentColor)
                    }.frame(maxWidth: 30, minHeight: 110,
                            idealHeight: 130, maxHeight: 150, alignment: .top)
                    .padding(.vertical, -5).padding(.trailing, 20)

                    Text("Customer ready to work!")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "After all this simple steps, you'll can place your order.")
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(.lightGray)
                            .font(Font.system(size: 20, weight: .light, design: .rounded))
                    }.padding(.vertical, 30)
                }
                Spacer(minLength: 55)
            }.background(Color.clear).padding(.horizontal, 20)

            VStack {
                Spacer()
                NavigationLink(destination: PhoneVerifyView(phone: .constant(""), actorType: actorType)) {
                    HStack {
                        Text("Let`s begin!")
                            .lineLimit(1)
                            .ignoresSafeArea(.all)
                            .shadow(color: Color.secondary, radius: 1, x: 1, y: 1)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .fill(Color.accentColor))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(Color.white)
                                .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                    }
                }
            }.padding(.bottom, 25)

        }.navigationBarTitleDisplayMode(.inline).navigationTitle("Enrollment")
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                         options: [.allowContentDrag, .tapToDissmiss, .swipeToDismiss,
                                   .cornerRadius(25), .shadow(color: .lightGray, radius: 3, x: 3, y: 3),
                                   .noBottomPosition, .appleScrollBehavior,
                                   .dragIndicatorColor(Color.lightGray.opacity(0.5)),
                                   .showCloseButton(action: { self.bottomSheetPosition = .hidden })],
                         headerContent: {},
                         mainContent: {
                VStack {
                    Text(infoText)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(30)
                }.padding(20)
            })
    }

    func checkBottomSheetConds(text: String) {
        if text != self.infoText {
            if self.bottomSheetPosition == .middle {
                self.bottomSheetPosition = .hidden
                self.$infoText.wrappedValue = text
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.bottomSheetPosition = .middle
                }
            } else {
                self.$infoText.wrappedValue = text
                self.bottomSheetPosition = .middle
            }
        } else {
            self.bottomSheetPosition = self.bottomSheetPosition == .hidden ? .middle : .hidden
        }
    }
}

struct EnrollmentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EnrollmentInfoView(actorType: .PROVIDER)
        }
        .previewDevice("iPhone 6s")
    }
}

struct DottedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width - 0.5, y: rect.height))
        return path
    }
}

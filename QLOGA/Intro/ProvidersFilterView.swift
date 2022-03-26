//
//  ProvidersFilterView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProvidersFilterView: View {
    @State var distance: Double = 100.0
    @State var returnRate: Double = 50
    @State var minRate: Double = 4.0
    @State var orders: Double = 250
    @State var providerType: ProviderType = .All
    @State var personalVirifications: [VerificationType: Bool] = [
        VerificationType.IDs                     : true,
        VerificationType.Address                 : false,
        VerificationType.Avatar                  : false,
        VerificationType.RegistrationCertificate : false,
        VerificationType.ProfessionalInsurance   : false,
        VerificationType.Email                   : true,
    ]
    @State var personalCertifications: [CertificationType: Bool] = [
        CertificationType.BasicDisclosure            : false,
        CertificationType.ProtectingVulnerableGroups : false,
        CertificationType.DBS                        : false,
        CertificationType.AccessNI                   : false,
        CertificationType.none                       : true,
    ]

    var body: some View {
        VStack {
            Capsule()
                .fill(Color.lightGray)
                .frame(width: 145, height: 4)
                .padding(.top, 7)
                .padding(.horizontal, 5)
                .padding(.bottom, 7)
                .shadow(color: .lightGray.opacity(0.8), radius: 3, y: 3)
            HStack {
                Spacer()
                Text("Search Filter")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20,
                                      weight: .medium,
                                      design: .rounded))
                Spacer()
            }.padding(5)
            Divider()
            ScrollView {
                Group {
                    VStack(spacing: 25) {
                        Sliders
                        HStack {
                            Text("PROVIDER`S TYPE")
                                .foregroundColor(Color.pickerTitle)
                                .font(Font.system(size: 18,
                                                  weight: .regular,
                                                  design: .rounded))
                                .padding(.horizontal, 10)
                            Spacer()
                            Picker("PROVIDER`S TYPE", selection: $providerType) {
                                ForEach(ProviderType.allCases) { provider in
                                    Text(provider.rawValue)
                                        .underline()
                                        .font(Font.system(size: 18, weight: .bold, design: .rounded))
                                }
                            }.pickerStyle(.menu)
                        }.padding([.horizontal])

                        ProviderAdminVerification
                        ProviderVerification
                        ClearanceCertificates
                    }
                }.padding(.bottom)
            }.padding()
        }
    }
}

extension ProvidersFilterView {
    private var Sliders: some View {
        VStack(spacing: 25) {
            Section(content: {
                Slider(value: $distance, in: 0...200, step: 0.1)
                    .padding(10)
                    .accentColor(Color.accentColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                    .padding(.top, -15)
            }, header: {
                HStack {
                    Text("DISTANCE (miles): \(String(format: "%g", distance))")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }).padding([.horizontal])

            Section(content: {
                Slider(value: $returnRate, in: 0...100, step: 1)
                    .padding(10)
                    .accentColor(Color.accentColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                    .padding(.top, -15)
            }, header: {
                HStack {
                    Text("RETURN RATE: \(String(format: "%g", returnRate))%")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }).padding([.horizontal])

            Section(content: {
                Slider(value: $minRate, in: 0...5, step: 0.1)
                    .padding(10)
                    .accentColor(Color.accentColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                    .padding(.top, -15)
            }, header: {
                HStack {
                    Text("MINIMUM START RATING: \(String(format: "%g", minRate))")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }).padding([.horizontal])

            Section(content: {
                Slider(value: $orders, in: 0...500, step: 1)
                    .padding(10)
                    .accentColor(Color.accentColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                    .padding(.top, -15)
            }, header: {
                HStack {
                    Text("ORDERS DELIVERED: \(String(format: "%g", orders))")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }).padding([.horizontal])
        }
    }

    private var ProviderAdminVerification: some View {
        VStack {
            VStack {
                HStack {
                    Text("PROVIDER ADMIN VERIFICATIONS")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }

            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("ID")
                            .foregroundColor(personalVirifications[VerificationType.IDs] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.IDs] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.IDs] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.IDs]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Address")
                            .foregroundColor(personalVirifications[VerificationType.Address] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.Address] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.Address] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.Address]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Avatar")
                            .foregroundColor(personalVirifications[VerificationType.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.Avatar] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.Avatar]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                }
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
            .padding(.horizontal)
        }
    }

    private var ProviderVerification: some View {
        VStack {
            VStack {
                HStack {
                    Text("PROVIDER VERIFICATION")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("Registration certificate")
                            .foregroundColor(personalVirifications[VerificationType.RegistrationCertificate] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.RegistrationCertificate] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.RegistrationCertificate] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.RegistrationCertificate]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Professional Insurance")
                            .foregroundColor(personalVirifications[VerificationType.ProfessionalInsurance] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.ProfessionalInsurance] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.ProfessionalInsurance] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.ProfessionalInsurance]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Email")
                            .foregroundColor(personalVirifications[VerificationType.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalVirifications[VerificationType.Email] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationType.Email] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationType.Email]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                }
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
            .padding(.horizontal)
        }
    }

    private var ClearanceCertificates: some View {
        VStack {
            VStack {
                HStack {
                    Text("CLEARANCE CERTIFICATES")
                        .foregroundColor(Color.pickerTitle)
                        .font(Font.system(size: 18,
                                          weight: .regular,
                                          design: .rounded))
                        .padding(.horizontal, 10)
                    Spacer()
                }
            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("Disclosure Scotland: Basic Disclosure")
                            .foregroundColor(personalCertifications[CertificationType.BasicDisclosure] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationType.BasicDisclosure] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationType.BasicDisclosure] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationType.BasicDisclosure]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Disclosure Scotland: Protecting Vulnerable Groups")
                            .foregroundColor(personalCertifications[CertificationType.ProtectingVulnerableGroups] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationType.ProtectingVulnerableGroups] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationType.ProtectingVulnerableGroups] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationType.ProtectingVulnerableGroups]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("DBS: Disclosure and Barring Service")
                            .foregroundColor(personalCertifications[CertificationType.DBS] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalCertifications[CertificationType.DBS] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationType.DBS] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationType.DBS]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("AccessNI: Crimital Records Check")
                            .foregroundColor(personalCertifications[CertificationType.AccessNI] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationType.AccessNI] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationType.AccessNI] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationType.AccessNI]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("NONe")
                            .foregroundColor(personalCertifications[CertificationType.none] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationType.none] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationType.none] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationType.none]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                }
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
            .padding(.horizontal)
        }
    }
}

struct ProvidersFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ProvidersFilterView()
    }
}

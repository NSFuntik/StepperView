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
    @State var providerType: ProviderType = ProviderType.All
    @State var personalVirifications: [VerificationTypes : Bool] = [
        VerificationTypes.IDs : true,
        VerificationTypes.Address : false,
        VerificationTypes.Avatar : false,
        VerificationTypes.RegistrationCertificate : false,
        VerificationTypes.ProfessionalInsurance : false,
        VerificationTypes.Email : true,
    ]
    @State var personalCertifications: [CertificationTypes : Bool] = [
        CertificationTypes.BasicDisclosure : false,
        CertificationTypes.ProtectingVulnerableGroups : false,
        CertificationTypes.DBS : false,
        CertificationTypes.AccessNI : false,
        CertificationTypes.none : true
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
                    Spacer()    }
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
                    Spacer() }

            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("ID")
                            .foregroundColor(personalVirifications[VerificationTypes.IDs] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.IDs] == true ? "checkmark.circle.fill" : "circle" )
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.IDs] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.IDs]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Address")
                            .foregroundColor(personalVirifications[VerificationTypes.Address] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.Address] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.Address] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.Address]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Avatar")
                            .foregroundColor(personalVirifications[VerificationTypes.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.Avatar] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.Avatar]?.toggle()
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
                    Spacer() }
            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("Registration certificate")
                            .foregroundColor(personalVirifications[VerificationTypes.RegistrationCertificate] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.RegistrationCertificate] == true ? "checkmark.circle.fill" : "circle" )
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.RegistrationCertificate] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.RegistrationCertificate]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Professional Insurance")
                            .foregroundColor(personalVirifications[VerificationTypes.ProfessionalInsurance] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.ProfessionalInsurance] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.ProfessionalInsurance] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.ProfessionalInsurance]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Email")
                            .foregroundColor(personalVirifications[VerificationTypes.Avatar] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalVirifications[VerificationTypes.Email] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalVirifications[VerificationTypes.Email] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalVirifications[VerificationTypes.Email]?.toggle()
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
                    Spacer() }
            }.padding([.horizontal])
            VStack {
                Group {
                    HStack {
                        Text("Disclosure Scotland: Basic Disclosure")
                            .foregroundColor(personalCertifications[CertificationTypes.BasicDisclosure] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationTypes.BasicDisclosure] == true ? "checkmark.circle.fill" : "circle" )
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationTypes.BasicDisclosure] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationTypes.BasicDisclosure]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("Disclosure Scotland: Protecting Vulnerable Groups")
                            .foregroundColor(personalCertifications[CertificationTypes.ProtectingVulnerableGroups] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationTypes.ProtectingVulnerableGroups] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationTypes.ProtectingVulnerableGroups] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationTypes.ProtectingVulnerableGroups]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("DBS: Disclosure and Barring Service")
                            .foregroundColor(personalCertifications[CertificationTypes.DBS] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)

                        Spacer()
                        Image(systemName: personalCertifications[CertificationTypes.DBS] == true ? "checkmark.circle.fill" : "circle")
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationTypes.DBS] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationTypes.DBS]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("AccessNI: Crimital Records Check")
                            .foregroundColor(personalCertifications[CertificationTypes.AccessNI] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationTypes.AccessNI] == true ? "checkmark.circle.fill" : "circle" )
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationTypes.AccessNI] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationTypes.AccessNI]?.toggle()
                            }
                    }.padding(.vertical)
                    Divider().padding(.horizontal, 20)
                    HStack {
                        Text("NONe")
                            .foregroundColor(personalCertifications[CertificationTypes.none] == true ? Color.accentColor : Color.pickerTitle)
                            .font(Font.system(size: 18,
                                              weight: .medium,
                                              design: .rounded))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: personalCertifications[CertificationTypes.none] == true ? "checkmark.circle.fill" : "circle" )
                            .scaleEffect(1.3)
                            .foregroundColor(personalCertifications[CertificationTypes.none] == true ? Color.accentColor : Color.pickerTitle)
                            .padding(.trailing, 15)
                            .onTapGesture {
                                personalCertifications[CertificationTypes.none]?.toggle()
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

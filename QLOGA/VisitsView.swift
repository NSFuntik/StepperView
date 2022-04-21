//
//  VisitsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/22/22.
//

import SwiftUI

struct VisitsView: View {
    var body: some View {
            ScrollView( showsIndicators: false) {
                VStack(alignment: .center, spacing: 15) {
                HStack {
                    Spacer()
                    Text("20/6/2021-28/6/2021")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("  Today  ")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.Orange)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Section("23/6/2021  WED") {
                    VStack {
                        HStack {
                            VStack {
                                Text("11:00 - 12:00")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Cancel")
                                        Spacer()
                                    }
                                    .padding(10).padding(.horizontal, 15)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }.foregroundColor(.red)

                            }.frame(width: UIScreen.main.bounds.width / 3)
                            Spacer()

                            VStack {
                                Text("N/A")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Approve")
                                        Spacer()
                                    }                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.accentColor))
                                }

                            }.frame(width: UIScreen.main.bounds.width / 3)
                        }
                        Divider().background(Color.infoBlue).frame(width: UIScreen.main.bounds.width / 3 * 2).padding(.vertical, 10)
                        HStack {
                            VStack {
                                Text("11:00 - 12:00")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Cancel")
                                        Spacer()
                                    }                                        .padding(10).padding(.horizontal, 15)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }.foregroundColor(.red)

                            }.frame(width: UIScreen.main.bounds.width / 3)
                            Spacer()
                            VStack {
                                Text("N/A")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Approve")
                                        Spacer()
                                    }
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.accentColor))
                                }
                            }.frame(width: UIScreen.main.bounds.width / 3)
                        }
                    }.padding(20).clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.infoBlue)).padding([.bottom, .horizontal], 5)
                }.frame(width: UIScreen.main.bounds.width - 40)
                    Section("23/6/2021  WED") {
                    VStack {
                        HStack {
                            VStack {
                                Text("11:00 - 12:00")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Cancel")
                                        Spacer()
                                    }                                        .padding(10).padding(.horizontal, 15)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }.foregroundColor(.red)

                            }.frame(width: UIScreen.main.bounds.width / 3)
                            Spacer()

                            VStack {
                                Text("N/A")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Approve")
                                        Spacer()
                                    }                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.accentColor))
                                }

                            }.frame(width: UIScreen.main.bounds.width / 3)
                        }
                    }.padding(20).clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.infoBlue)).padding([.bottom, .horizontal], 5)
                }.frame(width: UIScreen.main.bounds.width - 40)
                    Section("23/6/2021  WED") {
                    VStack {
                        HStack {
                            VStack {
                                Text("11:00 - 12:00")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Cancel")
                                        Spacer()
                                    }                                        .padding(10).padding(.horizontal, 15)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }.foregroundColor(.red)

                            }.frame(width: UIScreen.main.bounds.width / 3)
                            Spacer()

                            VStack {
                                Text("N/A")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Approve")
                                        Spacer()
                                    }                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.accentColor))
                                }

                            }.frame(width: UIScreen.main.bounds.width / 3)
                        }
                    }.padding(20).clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.infoBlue)).padding([.bottom, .horizontal], 5)
                }.frame(width: UIScreen.main.bounds.width - 40)
                    Section("23/6/2021  WED") {
                    VStack {
                        HStack {
                            VStack {
                                Text("11:00 - 12:00")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Cancel")
                                        Spacer()
                                    }                                        .padding(10).padding(.horizontal, 15)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
                                }.foregroundColor(.red)

                            }.frame(width: UIScreen.main.bounds.width / 3)
                            Spacer()

                            VStack {
                                Text("N/A")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.secondary)
                                Button {

                                } label: {
                                    HStack {
                                        Spacer()
                                        Text("Approve")
                                        Spacer()
                                    }                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.accentColor))
                                }

                            }.frame(width: UIScreen.main.bounds.width / 3)
                        }
                    }.padding(20).clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.infoBlue)).padding([.bottom, .horizontal], 5)
                }.frame(width: UIScreen.main.bounds.width - 40)
            }
        }.padding(.horizontal, 20)
            .navigationTitle("Visits: 5")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 10)
    }
}

struct VisitsView_Previews: PreviewProvider {
    static var previews: some View {
        VisitsView()
    }
}

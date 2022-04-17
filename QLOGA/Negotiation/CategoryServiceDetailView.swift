//
//  CategoryServiceDetailView.swift
//  
//
//  Created by Dmitry Mikhailov on 4/9/22.
//

import SwiftUI

struct CategoryServiceDetailView: View {
    @Binding var service: CategoryService
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text(service.name ?? "nil")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 42, alignment: .leading)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                ).frame(height: 45).padding(1).padding(.vertical, 10)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text(service.unit ?? "nil")
                            .foregroundColor(Color.lightGray)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    } icon: {
                        Text("Unit:")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                    Label {
                        Text(String(format: "%g.0", service.timeNorm ?? 0))
                            .foregroundColor(Color.lightGray)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    } icon: {
                        Text("Price:")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                    Text("Subject of service:")
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    Text(service.subject ?? "nil")
                        .foregroundColor(Color.lightGray)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                }
                Spacer()
                //Image("KitchenCleaner")
                AsyncImage(url: URL(string: service.avatarURL ?? "nil")) { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                } placeholder: {
                    Image("KitchenCleaner")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                }
                .frame(width: 120, height: 120, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
//                AsyncImage(url: URL(string: service.avatarURL))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Description:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Text(service.descr ?? "nil")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Exclusions:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Text(service.exclusions ?? "nil")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Works:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

                Text(service.works ?? "nil")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Conditions:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Text(service.works ?? "nil")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            Spacer()
        }.padding(.horizontal, 20)
            .navigationTitle("Selected service").navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryServiceDetailView(service: .constant(CategoryService.init(id: 110, sortOrder: 1, name: "Ladies’ haircut", descr: "Hair cut, wash, dry and styling services in your home from a professional women’s hair stylists.", unit: "haircut", unitDescr: "Haircut", subject: "Head hair", works: "Hair cutting, washing, drying, and styling", exclusions: "Estimated session length is 60 minutes", timeNorm: 180, avatarID: 612, avatarURL: "https://pub.qloga.com/p4p/services/08-110-ladies-regular-haircut.jpg")))
    }
}
/*

 "id": 110,
 "sortOrder": 1,
 "name": "Ladies’ haircut",
 "descr": "Hair cut, wash, dry and styling services in your home from a professional women’s hair stylists.",
 "unit": "haircut",
 "unitDescr": "Haircut",
 "subject": "Head hair",
 "works": "Hair cutting, washing, drying, and styling",
 "exclusions": "Estimated session length is 60 minutes",
 "timeNorm": 180,
 "avatarId": 612,
 "avatarUrl": "https://pub.qloga.com/p4p/services/08-110-ladies-regular-haircut.jpg"
 */

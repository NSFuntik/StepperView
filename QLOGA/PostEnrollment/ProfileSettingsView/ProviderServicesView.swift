//
//  ProviderServicesView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/18/22.
//

import Combine
import SwiftUI

final class SelectService: ObservableObject {
    public let objectWillChange = PassthroughSubject<Void, Never>()

    static let shared = SelectService()
    @Published var id: CategoryType.ID = CategoryType.Gas.id {
        willSet {
            objectWillChange.send()
        }
    }
}
struct ProviderServicesView: View {
    @StateObject var selectedService: SelectService = SelectService()
    @State private var scrollOffset: CGFloat = 0

    init(provider: Binding<Provider>) {
        UITableView.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
        UITableView.appearance().sectionIndexColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
        self._provider = provider
    }
    @State var isLimited = true
    @Binding var provider: Provider

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ServicesScrollView.frame(height: 100)
            VStack {
                HStack {
                    Text("Description")
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .medium, design: .rounded))
                    Spacer()
                }.padding(.vertical, 5)
                Text(Services.sorted(by: { $0.id < $1.id })[selectedService.id].description ?? descr)
                    .foregroundColor(Color.black.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 14, weight: .light, design: .rounded))
                    .lineLimit(isLimited ? 4 : 10)
                HStack {
                    Text(isLimited ? "Show more" : "Show less")
                        .foregroundColor(Color.accentColor)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 13, weight: .light, design: .rounded))
                        .padding(.top, -5)
                        .onTapGesture { isLimited.toggle() }
                    Spacer()
                }
            }.padding(.bottom, 20)

            ScrollView(showsIndicators: false) {
                VStack {
                    RemovableTagListView(selected: $selectedService.id , isRemovable: .constant(false), categoriesVM: .init(),
                                         tags:
                                            Binding { Set($provider.choicedServices.filter { !$0.services.isEmpty }
                                                .sorted(by: { $0.id.wrappedValue < $1.id.wrappedValue })

                                                .map { "\($0.name.wrappedValue): \($0.services.count)" })
                    } set: { tags in  })
                    Spacer()
                }.padding(.bottom, 10)
                VStack {
                    ForEach(Services.sorted(by: { $0.id < $1.id })[$selectedService.id.wrappedValue].services, id: \.id) { type in
                        Section {
                            NavigationLink {
                                ProviderAddServicesView(choisedServices:
                                                            $provider.choicedServices.sorted(by: { $0.id.wrappedValue < $1.id.wrappedValue })[selectedService.id].projectedValue.services,
                                                        serviceType: ServiceCleaningType(rawValue: type.id) ?? .CompleteHome)
                            } label: {
                                HStack {
                                    Text(type.title)
                                        .foregroundColor(Color.black.opacity(0.9))
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        .lineLimit(1)
                                        .padding(.leading, 10)
                                    Spacer()
                                    Text(
                                        $provider.choicedServices.sorted(by: { $0.id.wrappedValue < $1.id.wrappedValue }).filter { $0.id == Services[$selectedService.id.wrappedValue].id }.first?.projectedValue.services.wrappedValue.contains(type) ?? false ? "£160.00" : "")
                                    .foregroundColor(Color.secondary)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    .lineLimit(1)
                                    .padding(.leading, 5)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                }.padding(5)
                            }
                            Divider().padding(.horizontal, -10).padding(.leading, 25)
                        }
                    }
                }.padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary
                            .opacity(0.7), lineWidth: 1).padding(1))
                Spacer(minLength: 20)
            }
            Spacer()
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Services & Conditions")
    }
}

extension ProviderServicesView {
    var ServicesScrollView: some View {

        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                HStack {
                    ForEach(Services.sorted(by: { $0.id < $1.id })) { service in
                        Button { $selectedService.id.wrappedValue = service.id }
                    label: {
                        VStack {
                            Image(service.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke($selectedService.id.wrappedValue == service.id ? Color.accentColor : Color.lightGray.opacity(0.6),
                                                lineWidth: $selectedService.id.wrappedValue == service.id ? 2.0 : 1.5)
                                ).padding(.bottom, -3).padding(.top, 1)
                            Text(service.name)
                                .foregroundColor(Color.black)

                                .font(.system(size: 15.0, weight: .light, design: .rounded))
                                .padding(.bottom, 5)
                        }.environmentObject(selectedService)
                            .id($selectedService.id.wrappedValue)
                            .frame(maxHeight: 90)
                            .padding(.horizontal, 10)
                    }
                    }.onChange(of: $selectedService.id.wrappedValue) { i in
                        withAnimation {

                            value.scrollTo($selectedService.id.wrappedValue, anchor: .center)
                        }
                    }
                }
            }.padding(.leading, -8)
        }.padding(.top, 10)

    }
}

struct ProviderServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderServicesView(provider: .constant(testProvider))
                .previewDevice("iPhone 6s").navigationTitle("Provider Search")
        }
    }
}

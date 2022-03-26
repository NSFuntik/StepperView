//
//  ProviderPortfolioView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

// MARK: - ProviderPortfolioView

struct ProviderPortfolioView: View {
    private var numberofImages = testProvider.portfolio.images.count
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var image = Image("PortfolioImage0")
    @State var showImageViewer = false
    @State private var currentIndex = 0
    @State private var comment: String = ""

    func previous() {
        withAnimation {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : numberofImages - 1
        }
    }

    func next() {
        withAnimation {
            currentIndex = currentIndex < numberofImages ? currentIndex + 1 : 0
        }
    }

    var controls: some View {
        HStack {
            Button {
                previous()
            } label: {
                Image(systemName: "chevron.left")
            }
            Spacer().frame(width: 100)
            Button {
                next()
            } label: {
                Image(systemName: "chevron.right")
            }
            .accentColor(.accentColor)
        }
    }

    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack(alignment: .center, spacing: 10) {
                    TabView(selection: $currentIndex) {
                        ForEach(0..<numberofImages, id: \.self) {
                            num in Image("PortfolioImage\(num)")
                                .resizable()
                                .scaledToFill()
                                .tag(num)
                                .onTapGesture {
                                    image = Image("PortfolioImage\($currentIndex.wrappedValue)")
                                    showImageViewer.toggle()
                                }.padding(1)
                        }
                    }.tabViewStyle(PageTabViewStyle())
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                        .onReceive(timer, perform: { _ in
                            next()
                        })
                }
            }
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 2) {
                            ForEach(0..<numberofImages, id: \.self) { num in
                                Image("PortfolioImage\(num)")
                                    .resizable()
                                    .frame(width: 75, height: 45)
                                    .scaledToFill()
                                    .tag(num)
                                    .onTapGesture {
                                        $currentIndex.wrappedValue = num
                                    }
                            }
                        }
                    }.frame(width: 75 * CGFloat(numberofImages) + CGFloat(numberofImages * 2))
                    Spacer()
                }
            }.frame(width: UIScreen.main.bounds.width, height: 45)
            ScrollView {
                Text(testProvider.portfolio.description)
                    .font(Font.system(size: 17, weight: .light, design: .rounded))
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .padding(5)
                Spacer()
            }

            .navigationBarTitle("Portfolio")
            .navigationBarTitleDisplayMode(.inline)
        }.padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.width + 40, maxHeight: .infinity)
            .overlay(ImageViewer(image: self.$image,
                                 viewerShown: self.$showImageViewer))
    }
}

// MARK: - ProviderPortfolioView_Previews

struct ProviderPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderPortfolioView()
        }.previewDevice("iPhone 6s")
    }
}

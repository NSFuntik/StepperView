//
//  ProviderPortfolioView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
//import ImageViewer
struct ProviderPortfolioView: View {
    @State var image = Image("PortfolioImage0")
    @State var  showImageViewer = false
    private var numberofImages = 6
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State private var comment:String = ""

    func previous() {
        withAnimation {
            currentIndex = currentIndex > 0 ? currentIndex - 1 : numberofImages - 1
        }
    }

    func next() {
        withAnimation{
            currentIndex = currentIndex < numberofImages ? currentIndex + 1 : 0
        }
    }

    var controls: some View {
        HStack{
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
                VStack(spacing: 20) {
//                    ZStack {
                        TabView(selection: $currentIndex) {
                            ForEach(0..<numberofImages) {
                                num in Image("PortfolioImage\(num)")
                                    .resizable()
                                    .scaledToFill()
//                                    .shadow(color: .secondary.opacity(0.5), radius: 3)
                                    .tag(num)
                                    .onTapGesture {
                                        image = Image("PortfolioImage\($currentIndex.wrappedValue)")
                                        showImageViewer.toggle()
                                    }.padding(1)
                            }
                        }.tabViewStyle(PageTabViewStyle())
                            .frame(width: proxy.size.width, height: proxy.size.height / 2)
                            .onReceive(timer, perform: { _ in
                                next()
                            })
                        VStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 1) {
                                    ForEach(0..<numberofImages) {
                                        num in Image("PortfolioImage\(num)")
                                            .resizable()
                                            .scaledToFill()

                                            .tag(num)
//                                            .onTapGesture {
//                                                $currentIndex = num
//                                            }
                                    }
                                }.frame(height: 45)//.padding(.top, 3)
                            }//.padding(.top, 20)
                        }
//                    }


//                    controls
//                        .padding(10)
                    ScrollView {
                        Text(testProvider.portfolio?.description ?? "").font(Font.system(size: 17, weight: .light, design: .rounded)).padding()
                        Spacer()
                    }//.padding(.top,20)
//                        .overlay(RoundedRectangle(cornerRadius: 10)
//                            .stroke(lineWidth: 1.0)
//                            .foregroundColor(Color.lightGray)
////                            .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3)
//                        )//.padding()
                }
            }

        }.navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Portfolio")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
    }
}
struct ProviderPortfolioView_Previews: PreviewProvider {
        static var previews: some View {
            ProviderPortfolioView()
    }
}



//
//  LanguagesPickerView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/17/22.
//

import SwiftUI

struct LanguagesPickerView: View {
	@Binding var languages: [Language]
	@Environment(\.presentationMode) var presentationMode

	@State var languagesSet: [Language: Bool] = [
		.English : false,
		.French  : false,
		.Germany : false,
		.Dutch   : false,
		.Spain   : false,
		.Hebrow  : false
	]

	var body: some View {
		VStack {
			VStack {
				Group {
					HStack {
						Text("English")
							.foregroundColor(languagesSet[.English] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)
						Spacer()
						Image(systemName: languagesSet[.English] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.English] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.English]?.toggle()
							}
					}.frame(height: 40).padding(.top, 5)
					HStack {
						Text("French")
							.foregroundColor(languagesSet[.French] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)
						Spacer()
						Image(systemName: languagesSet[.French] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.French] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.French]?.toggle()
							}
					}.frame(height: 40)
					HStack {
						Text("Germany")
							.foregroundColor(languagesSet[.Germany] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)

						Spacer()
						Image(systemName: languagesSet[.Germany] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.Germany] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.Germany]?.toggle()
							}
					}.frame(height: 40)
					HStack {
						Text("Dutch")
							.foregroundColor(languagesSet[.Dutch] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)
						Spacer()
						Image(systemName: languagesSet[.Dutch] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.Dutch] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.Dutch]?.toggle()
							}
					}.frame(height: 40)
					HStack {
						Text("Spain")
							.foregroundColor(languagesSet[.Spain] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)
						Spacer()
						Image(systemName: languagesSet[.Spain] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.Spain] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.Spain]?.toggle()
							}
					}.frame(height: 40)
					HStack {
						Text("Hebrow")
							.foregroundColor(languagesSet[.Hebrow] == true ? Color.accentColor : Color.pickerTitle)
							.font(Font.system(size: 18,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.leading, 15)
						Spacer()
						Image(systemName: languagesSet[.Hebrow] == true ? "checkmark.circle.fill" : "circle")
							.scaleEffect(1.3)
							.foregroundColor(languagesSet[.Hebrow] == true ? Color.accentColor : Color.pickerTitle)
							.padding(.trailing, 15)
							.onTapGesture {
								languagesSet[.Hebrow]?.toggle()
							}
					}.frame(height: 40, alignment: .center).padding(.bottom, 5)
				}
			}.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(lineWidth: 1.0)
					.foregroundColor(Color.lightGray))
				.padding(.horizontal, 20).padding(.top, 10)
			Spacer()
		}.onAppear {
			languagesSet = [
				.English : $languages.wrappedValue.contains(Language.English),
				.French  : $languages.wrappedValue.contains(Language.French),
				.Germany : $languages.wrappedValue.contains(Language.Germany),
				.Dutch   : $languages.wrappedValue.contains(Language.Dutch),
				.Spain   : $languages.wrappedValue.contains(Language.Spain),
				.Hebrow  : $languages.wrappedValue.contains(Language.Hebrow)
			]
		}
		.toolbar {
			Button("Save", role: .destructive) {
				$languages.wrappedValue = []
				if languagesSet[.English] == true {
					$languages.wrappedValue.append(Language.English)
				}
				if languagesSet[.French] == true {
					$languages.wrappedValue.append(Language.French)
				}
				if languagesSet[.Germany] == true {
					$languages.wrappedValue.append(Language.Germany)
				}
				if languagesSet[.Dutch] == true {
					$languages.wrappedValue.append(Language.Dutch)
				}
				if languagesSet[.Spain] == true {
					$languages.wrappedValue.append(Language.Spain)
				}
				if languagesSet[.Hebrow] == true {
					$languages.wrappedValue.append(Language.Hebrow)
				}
				print($languages.wrappedValue)
				self.presentationMode.wrappedValue.dismiss()
			}
		}
		.navigationBarTitle("Spoken language").navigationBarTitleDisplayMode(.inline)
	}
}

struct LanguagesPickerView_Previews: PreviewProvider {
	static var previews: some View {
		LanguagesPickerView(languages: .constant([Language.English]))
	}
}

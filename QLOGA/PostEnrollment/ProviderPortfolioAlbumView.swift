//
//  ProviderPortfolioAlbumView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

enum Focusable: Hashable {
	case none
	case row(id: String)
}

struct ProviderPortfolioAlbumView: View {
	// MARK: Internal

	@Binding var provider: Provider
    @State var folders: Set<PortfolioFolder> = []
	@FocusState var focusedReminder: Focusable?
	@FocusState var isFocused: Bool
	@State var isFocusing: Bool = false
	@State var createFolder = false
	@State var isWholeSelected = false
	@State var editMode: EditMode = .inactive
	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .center) {
				ForEach($provider.portfolioFolders, id: \.self) { folder in
					Section {
						NavigationLink { AlbumFolderView(provider: $provider, folder: folder).padding(.horizontal, 10) }
                    label: {
								VStack {
									HStack {
										if $editMode.wrappedValue.isEditing == true {
											Image(systemName: folder.isPicked.wrappedValue ? "checkmark.circle.fill" : "circle")
												.scaleEffect(1.3)
												.foregroundColor(folder.isPicked.wrappedValue == true ? Color.accentColor : Color.pickerTitle)
												.padding(.horizontal, 10)
												.onTapGesture {
													if folder.isPicked.wrappedValue == true {
														folder.isPicked.wrappedValue = false
														folders.remove(folder.wrappedValue)
													} else {
														folder.isPicked.wrappedValue = true
														folders.insert(folder.wrappedValue)
													}
												}
										}
										Image(uiImage: (folder.images.first?.image.wrappedValue ?? UIImage(named: "FolderImage"))!)
											.resizable()
											.scaledToFill()
											.frame(width: 100, height: 100, alignment: .center)
											.clipShape(RoundedRectangle(cornerRadius: 10))

										VStack {
											Spacer()
											if $isFocusing.wrappedValue == true, folder.isFocused.wrappedValue {
												TextField(folder.title.wrappedValue, text: folder.title)
													.font(Font.system(size: 20, weight: .regular, design: .rounded))
													.foregroundColor(Color.infoBlue.opacity(0.9))
													.multilineTextAlignment(.leading)
													.lineLimit(1)
													.tag(folder.id)
													.focused($isFocused, equals: folder.isFocused.wrappedValue)
													.focused($focusedReminder, equals: .row(id: folder.id))
													.onAppear {
														$isFocused.wrappedValue = true
													}
													.onSubmit {
														$isFocusing.wrappedValue = false
														folder.isFocused.wrappedValue = false
													}
											} else {
												HStack {
													Text(folder.title.wrappedValue)
														.foregroundColor(Color.black.opacity(0.9))
														.multilineTextAlignment(.leading)
														.font(Font.system(size: 20, weight: .regular, design: .rounded))
														.lineLimit(1)
														.padding(5)
													Spacer()
												}
											}
											Spacer()
											HStack {
												Text(folder.images.count.description + " items")
													.foregroundColor(Color.secondary.opacity(0.9))
													.multilineTextAlignment(.leading)
													.font(Font.system(size: 17, weight: .regular, design: .rounded))
													.lineLimit(1)
													.padding(5)
												Spacer()
											}
											Spacer()
										}
										Spacer()
										Image(systemName: "chevron.right")
											.foregroundColor(Color.accentColor)
											.font(Font.system(size: 20, weight: .regular, design: .rounded))

									}.frame(height: 100, alignment: .center).padding(10)
									Divider().padding(.horizontal, 5).padding(.top, -4)
								}
							}
					}.frame(height: 120, alignment: .center)
						.contextMenu {
							Button {
								folder.isFocused.wrappedValue = true
								focusedReminder = .row(id: folder.id)
								isFocused = true
								isFocusing = true
							} label: {
								Label("Rename", systemImage: "pencil")
							}

							Button {
								provider.portfolioFolders = provider.portfolioFolders.filter { $0.id != folder.id }
							} label: {
								Label("Delete", systemImage: "trash")
							}
						}
				}.onDelete { _ in provider.portfolioFolders = provider.portfolioFolders.filter { $0.isPicked != true }
				}
			}
		}
		.alert(isPresented: $createFolder, TextAlert(title: "Enter folder's name", placeholder: "New folder", accept: "Accept", cancel: "Cancel") { title in

			provider.portfolioFolders.append(PortfolioFolder(title: title ?? "New folder", images: [], isFocused: false))
		})

		.toolbar {
			HStack {
				EditButton
				Menu {
					AddDelButton
					Button {
						if isWholeSelected == false {
							for folder in $provider.portfolioFolders {
								folder.wrappedValue.isPicked = true
								isWholeSelected = true
								self.editMode = .active
							}
						} else {
							for folder in $provider.portfolioFolders {
								folder.wrappedValue.isPicked = false
								isWholeSelected = false
								self.editMode = .inactive
							}
						}
					} label: {
						if isWholeSelected == false {
							Label("Select all folders", systemImage: "text.badge.checkmark")
						} else {
							Label("Deselect all folders", systemImage: "text.badge.minus")
						}
					}
				} label: {
					Image(systemName: "ellipsis.circle")
						.resizable()
						.foregroundColor(.secondary)
						.scaledToFit()
						.frame(width: 20, height: 20, alignment: .trailing)
						.padding(5)
				}
			}
		}.environment(\.editMode, $editMode)
		.animation(.interactiveSpring(), value: editMode)
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle("Albums")
	}

	// MARK: Private

	private var EditButton: some View {
		Button(action: {
			self.editMode.toggle()
			self.folders = Set<PortfolioFolder>()
		}) {
			Text(self.editMode.title)
		}
	}

	private var AddDelButton: some View {
		if editMode == .inactive && !isWholeSelected {
			return Button(action: addItem) { Label("New folder", systemImage: "folder.badge.plus") }
		} else {
			return Button(action: deleteItems) { Label("Delete selected folders", systemImage: "trash") }
		}
	}

	private func addItem() {
		$createFolder.wrappedValue = true
	}

	private func deleteItems() {
		$provider.portfolioFolders.wrappedValue = $provider.portfolioFolders.wrappedValue.filter { $0.isPicked != true }
		folders = Set<PortfolioFolder>()
	}
}

extension EditMode {
	var title: String {
		self == .active ? "Done" : "Edit"
	}

	mutating func toggle() {
		self = self == .active ? .inactive : .active
	}
}

struct ProviderPortfolioAlbumView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProviderPortfolioAlbumView(provider: .constant(testProvider))
		}.previewDevice("iPhone 6s")
	}
}

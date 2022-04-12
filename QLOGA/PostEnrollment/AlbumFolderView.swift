//
//  AlbumFolderView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import Photos
import SwiftUI

struct AlbumFolderView: View {
	// MARK: Internal

	@Binding var provider: Provider
	@Binding var folder: PortfolioFolder
	@StateObject var viewModel = ViewModel()

	@State var focusedImage: PortfolioImage = .init(title: "", uploadDate: "")
	@FocusState var focusedReminder: Focusable?
	@FocusState var isFocused: Bool
	@State var isEditing = false
	@State var showActionSheet = false
	@State var showImageViewer = false
	@State var isFocusing: Bool = false

	@State var photos = Set<PortfolioImage>()
	@State var image = Image("PortfolioImage0")
	@State var editMode: EditMode = .inactive
	@Environment(\.presentationMode) var presentationMode
	var colums = [GridItem(spacing: 10), GridItem(spacing: 10)]

	var body: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				LazyVGrid(columns: colums, spacing: 10) {
					ForEach($provider.portfolioFolders.filter { $0.title.wrappedValue == $folder.title.wrappedValue }.first!.images, id: \.self)
						{ photo in

							ZStack {
								Image(uiImage: photo.image.wrappedValue)
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(width: 160, height: 160)
									.cornerRadius(15)
									.clipped()
									.pinchToZoom()
									.onTapGesture {
										image = Image(uiImage: photo.image.wrappedValue)
										showImageViewer.toggle()
									}

								VStack {
									HStack {
										Spacer()
										if $editMode.wrappedValue.isEditing == true {
											Image(systemName: photo.isPicked.wrappedValue ? "checkmark.circle.fill" : "circle")
												.resizable()
												.font(.system(size: 20, weight: .light, design: .rounded))
												.foregroundColor(photo.isPicked.wrappedValue == true ? Color.accentColor : Color.white)
												.scaledToFit()
												.frame(width: 25, height: 25, alignment: .trailing)
												.padding(2)
												.onTapGesture {
													if photo.isPicked.wrappedValue == true {
														photo.isPicked.wrappedValue = false
														photos.remove(photo.wrappedValue)
													} else {
														photo.isPicked.wrappedValue = true
														photos.insert(photo.wrappedValue)
													}
												}
										}
									}
									Spacer()
									HStack {
										if $isFocusing.wrappedValue == true, photo.isFocused.wrappedValue {
											TextField("", text: photo.title)
												.focused($isFocused, equals: photo.isFocused.wrappedValue == true)
												.frame(width: 100, height: 30)
												.foregroundColor(.infoBlue)
												.font(.system(size: 15, weight: .regular, design: .rounded))
												.clipped()
												.focused($focusedReminder, equals: .row(id: photo.id))
												.onSubmit {
													photo.isFocused.wrappedValue = false
													$focusedImage.wrappedValue = PortfolioImage(title: "", uploadDate: "")
													$isFocused.wrappedValue = false
												}
												.onAppear {
													$focusedReminder.wrappedValue = .row(id: photo.id)
													photo.isFocused.wrappedValue = true
													$isFocused.wrappedValue = true
												}
										} else {
											Text(photo.title.wrappedValue)
												.frame(width: 120, height: 30)
												.font(.system(size: 15, weight: .regular, design: .rounded))
												.clipped()
										}
										Spacer(minLength: 20)
										Menu {
											Button {
												$isFocusing.wrappedValue = true
												focusedReminder = .row(id: photo.id)
												photo.isFocused.wrappedValue = true
												$isFocused.wrappedValue = true
											} label: {
												Label("Rename", systemImage: "pencil")
											}
											Button {
												$folder.images.wrappedValue = $folder.images.wrappedValue.filter { $0.image != photo.image.wrappedValue }
											} label: {
												Label("Delete", systemImage: "trash")
											}
										} label: {
											Image(systemName: "ellipsis.circle")
												.resizable()
												.foregroundColor(.secondary)
												.font(.system(size: 20, weight: .light, design: .rounded))
												.scaledToFit()
												.frame(width: 25, height: 25, alignment: .trailing)
												.padding(5)
												.padding(.trailing, 5)
										}.menuStyle(DefaultMenuStyle())
									}.frame(width: 160, height: 30)
										.background(Rectangle().frame(width: 160, height: 30)
											.foregroundColor(Color.white.opacity(0.95)))
								}.frame(width: 160, height: 160)
							}
							.contextMenu {
								Button {
									photo.isFocused.wrappedValue = true
									focusedReminder = .row(id: photo.id)
									$isFocused.wrappedValue = true
									$isFocusing.wrappedValue = true
								} label: {
									Text("Rename")
									Image(systemName: "pencil")
								}

								Button {
									$folder.images.wrappedValue = $folder.images.wrappedValue.filter { $0.id != photo.id.wrappedValue }
								} label: {
									Label("Delete", systemImage: "trash")
								}
							}
						}.padding(10)
				}
			}
		}
		.actionSheet(isPresented: $showActionSheet, content: {
			ActionSheet(title: Text("Source of photo"), message: Text("Choose source of new image"), buttons: [
				.default(Text("Take a picture"), action: {
					viewModel.takePhoto()
				}),
				.default(Text("From phone galery"), action: {
					viewModel.choosePhoto()
				}),
				.default(Text("From QLOGA media library"), action: {
					viewModel.choosePhoto()
				}),
				.cancel()
			])
		})
		.fullScreenCover(isPresented: $viewModel.isPresentingImagePicker, content: {
			ImagePicker(sourceType: viewModel.sourceType) { image in
				let formatter = DateFormatter()
				formatter.dateFormat = "dd/MM/yy HH:mm"
				let string: String = formatter.string(from: Date())
				$folder.images.wrappedValue.append(PortfolioImage(title: "Image \($folder.images.wrappedValue.count)",
				                                                  uploadDate: string, isFocused: false, uiimage: image))
				$viewModel.isPresentingImagePicker.wrappedValue = false
			}
		})
		.toolbar {
			HStack {
				EditButton
				Button {
					if editMode == .inactive {
						$showActionSheet.wrappedValue = true
					} else {
						$folder.images.wrappedValue = $folder.images.wrappedValue.filter { $0.isPicked != true }
						photos = Set<PortfolioImage>()
					}
				} label: {
					Image(systemName: editMode == .inactive ? "plus.circle" : "trash")
						.resizable()
						.foregroundColor(editMode == .inactive ? .accentColor : .red)
						.scaledToFit()
						.frame(width: 20, height: 20, alignment: .trailing)
						.padding(5)
				}
			}
		}
		.animation(.interactiveSpring(), value: $editMode.wrappedValue)
		.navigationTitle($folder.title.wrappedValue).navigationBarTitleDisplayMode(.inline)
		.environment(\.editMode, $editMode)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.overlay(ImageViewer(image: self.$image,
		                     viewerShown: self.$showImageViewer))
	}

	// MARK: Private

	private var EditButton: some View {
		Button(action: {
			self.editMode.toggle()
			self.photos = Set<PortfolioImage>()
		}) {
			Text(self.editMode.title)
		}
	}
}

extension AlbumFolderView {
	final class ViewModel: ObservableObject {
		@Published var selectedImage: UIImage?
		@Published var addedImages: [PortfolioImage] = []

		@Published var isPresentingImagePicker = false
		private(set) var sourceType: ImagePicker.SourceType = .camera

		func choosePhoto() {
			sourceType = .photoLibrary
			isPresentingImagePicker = true
		}

		func takePhoto() {
			sourceType = .camera
			isPresentingImagePicker = true
		}

		func didSelectImage(_ image: UIImage?) {
			guard let selectedImage = image else {
				isPresentingImagePicker = false
				return
			}
			self.selectedImage = selectedImage
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yy HH:mm"
			let string: String = formatter.string(from: Date())
			//        completion( PortfolioImage(title: "New Image \(addedImages.count)", uploadDate: string, isFocused: false, uiimage: selectedImage))
			addedImages.append(PortfolioImage(title: "New Image \(addedImages.count)", uploadDate: string, isFocused: false, uiimage: selectedImage))
			isPresentingImagePicker = false
		}
	}
}

struct PAlbumFolderView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			AlbumFolderView(provider: .constant(testProvider), folder: .constant(testProvider.portfolioFolders.first!)).padding(.horizontal, 10)
		}.previewDevice("iPhone 6s")
	}
}

struct ImagePicker: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIImagePickerController
	typealias SourceType = UIImagePickerController.SourceType
	final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		// MARK: Lifecycle

		init(completionHandler: @escaping (UIImage?) -> Void) {
			self.completionHandler = completionHandler
		}

		// MARK: Internal

		let completionHandler: (UIImage?) -> Void

		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
			let image: UIImage? = {
				if let image = info[.editedImage] as? UIImage {
					return image
				}
				return info[.originalImage] as? UIImage
			}()
			completionHandler(image)
		}

		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			completionHandler(nil)
		}
	}

	let sourceType: SourceType
	let completionHandler: (UIImage?) -> Void

	func makeUIViewController(context: Context) -> UIImagePickerController {
		let viewController = UIImagePickerController()
		viewController.allowsEditing = true
		viewController.delegate = context.coordinator
		viewController.sourceType = sourceType
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
	func makeCoordinator() -> Coordinator {
		return Coordinator(completionHandler: completionHandler)
	}
}

extension Set {
    var toArray: Array<Any> {
        return Array(self)
    }
}

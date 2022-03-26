//
//  TextFieldAlert.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/20/22.
//

import SwiftUI
import UIKit

struct TextFieldClearButton: ViewModifier {
	@Binding var fieldText: String

	func body(content: Content) -> some View {
		content
			.safeAreaInset(edge: .trailing) {
				if !fieldText.isEmpty {
					HStack {
						Button {
							fieldText = ""
						} label: {
							Image(systemName: "multiply.circle.fill")
						}
						.foregroundColor(.secondary.opacity(0.5))
					}
				}
			}
	}
}

extension View {
	func showClearButton(_ text: Binding<String>) -> some View {
		modifier(TextFieldClearButton(fieldText: text))
	}
}

extension UIAlertController {
	convenience init(alert: TextAlert) {
		self.init(title: alert.title, message: nil, preferredStyle: .alert)
		addTextField { $0.placeholder = alert.placeholder }
		addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
			alert.action(nil)
		})
		let textField = textFields?.first
		addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
			alert.action(textField?.text)
		})
	}
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
	final class Coordinator {

		init(_ controller: UIAlertController? = nil) {
			self.alertController = controller
		}

		var alertController: UIAlertController?
	}

	@Binding var isPresented: Bool
	let alert: TextAlert
	let content: Content

	func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
		UIHostingController(rootView: content)
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator()
	}

	func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
		uiViewController.rootView = content
		if isPresented, uiViewController.presentedViewController == nil {
			var alert = self.alert
			alert.action = {
				self.isPresented = false
				self.alert.action($0)
			}
			context.coordinator.alertController = UIAlertController(alert: alert)
			uiViewController.present(context.coordinator.alertController!, animated: true)
		}
		if !isPresented, uiViewController.presentedViewController == context.coordinator.alertController {
			uiViewController.dismiss(animated: true)
		}
	}
}

public struct TextAlert {
	public var title: String
	public var placeholder: String = ""
	public var accept: String = "OK"
	public var cancel: String = "Cancel"
	public var action: (String?) -> ()
}

public extension View {
	func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
		AlertWrapper(isPresented: isPresented, alert: alert, content: self)
	}
}

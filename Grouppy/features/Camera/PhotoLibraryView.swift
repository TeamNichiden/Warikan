//
//  PhotoLibraryView.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/09.
//

import PhotosUI
import SwiftUI

struct PhotoLibraryView: UIViewControllerRepresentable {
  @Binding var icon: UIImage?
  @Environment(\.dismiss) private var dismiss
  var onImagePicked: ((UIImage) -> Void)? = nil

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: PhotoLibraryView

    init(_ parent: PhotoLibraryView) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      guard let provider = results.first?.itemProvider else {
        self.parent.dismiss()
        return
      }

      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, _ in
          DispatchQueue.main.async {
            self.parent.icon = image as? UIImage
            if let img = image as? UIImage {
              self.parent.onImagePicked?(img)
            }
            self.parent.dismiss()
          }
        }
      } else {
        parent.dismiss()
      }
    }
  }
}

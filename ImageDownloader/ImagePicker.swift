//
//  ImagePicker.swift
//  PhotoLibrary
//
//  Created by Vova on 16/09/2022.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    var closure: (UIImage?, ImagePickerErrors?) -> ()?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let photoPicker: ImagePicker
        
        init(_ photoPicker: ImagePicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                photoPicker.closure(image, nil)
            } else {
                photoPicker.closure(nil, ImagePickerErrors.unknown)
            }
            picker.dismiss(animated: true)
        }
    }
    
    enum ImagePickerErrors: String {
        case unknown = "Unknown Error"
    }
}

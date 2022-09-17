//
//  ViewModel.swift
//  PhotoLibrary
//
//  Created by Vova on 17/09/2022.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var text: String = ""
    @Published private(set) var photos: [UIImage] = []
    @Published private(set) var error: String = ""
    var isShowAlert: Bool {
        get {
            error != ""
        }
        set(newValue) {
            if !newValue {
                error = ""
            }
        }
    }
    @AppStorage("numOfPhotos") private(set) var numOfPhotos: Int = 0
    
    init() {
        getImages()
    }
    
    func getImages() {
        for index in 0..<numOfPhotos {
            guard
                let image = LocalFileManager.shared.getImage(for: getPhotoName(index: index))
            else { return }
            self.photos.append(image)
        }
    }
    
    func downloadImage(url: String) {
        text = ""
        guard
            let url = URL(string: url),
              url.scheme == "https"
        else {
            error = "Invalid URL"
            return
        }
        NetworkManager.shared.downloadData(url: url) { data in
            DispatchQueue.main.async {
                guard
                    let data = data,
                    let image = UIImage(data: data) else { return }
                if LocalFileManager.shared.saveImage(image: image, for: self.getPhotoName()) {
                    self.photos.append(image)
                    self.numOfPhotos += 1
                } else {
                    self.error = "Error Saving Image"
                }
            }
        }
    }
    
    func getPhotoName() -> String {
        return "photo\(numOfPhotos).jpg"
    }
    
    func getPhotoName(index: Int) -> String {
        return "photo\(index).jpg"
    }
}

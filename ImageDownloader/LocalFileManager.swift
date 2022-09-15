//
//  LocalFileManager.swift
//  PhotoLibrary
//
//  Created by Vova on 17/09/2022.
//

import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init() {
    }
    
    func saveImage(image: UIImage, for name: String) -> Bool{
        guard
            let path = getPath(for: name),
            let data = image.pngData() else {
            return false
        }
        do {
            try data.write(to: path)
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
    func getImage(for name: String) -> UIImage? {
        guard
            let path = getPath(for: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func getPath(for name: String) -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(name)
    }
}

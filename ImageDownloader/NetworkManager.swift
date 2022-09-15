//
//  NetworkManager.swift
//  PhotoLibrary
//
//  Created by Vova on 17/09/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
    }
    
    func downloadData(url: URL, completion: @escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, responce, error in
            completion(data)
        }).resume()
    }
}

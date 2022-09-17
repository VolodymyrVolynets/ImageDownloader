//
//  CoreDataManager.swift
//  PhotoLibrary
//
//  Created by Vova on 17/09/2022.
//

import Foundation
import CoreData

class PersistanceController {
    static let shared = PersistanceController()
    private let container: NSPersistentContainer
    
    private init () {
        container = NSPersistentContainer(name: "CoreData")
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unsolved error: \(error)")
            }
        }
    }
    
    func saveContex() {
        do {
            try container.viewContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func delete(at offsets: IndexSet) {
        let photos = getPhotos()
        
        for index in offsets {
            let photo = photos[index]
            container.viewContext.delete(photo)
        }
        
        saveContex()
    }
    
    func getPhotos() -> [SavedPhoto] {
        let fetchRequest = NSFetchRequest<SavedPhoto>(entityName: "SavedPhoto")
        
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func addTask(fileName: String) {
        let photo = SavedPhoto(context: container.viewContext)
        photo.name = fileName
        saveContex()
    }
}

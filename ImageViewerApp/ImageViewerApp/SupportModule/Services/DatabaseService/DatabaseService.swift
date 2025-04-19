//
//  DatabaseService.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProtocol {
    func savePhoto(_ photo: UnsplashPhoto) async throws
    func removePhoto(withId id: String) async throws
    func isPhotoFavorite(id: String) async -> Bool
    func getFavoritePhotos() async -> [FavoritePhoto]
}

@MainActor
class DatabaseService: DatabaseServiceProtocol {
    private var realm: Realm
    
    init() throws {
        //When need migration then uncomment it
        //        let config = Realm.Configuration(
        //            schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
        //                if oldSchemaVersion < 1 {/* Nothing to do for first version*/}
        //            }
        //        )
        //        Realm.Configuration.defaultConfiguration = config
        
        do {
            self.realm = try Realm()
            print("Db Path: \(Realm.Configuration.defaultConfiguration.fileURL!)") //For testing purpose
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func savePhoto(_ photo: UnsplashPhoto) async throws {
        let favoritePhoto = FavoritePhoto(from: photo)
        try await MainActor.run {
            do {
                try realm.write {
                    realm.add(favoritePhoto, update: .modified)
                }
            } catch {
                throw error
            }
        }
    }
    
    func removePhoto(withId id: String) async throws {
        try await MainActor.run {
            guard let photoToDelete = realm.object(ofType: FavoritePhoto.self, forPrimaryKey: id) else {
                return
            }
            
            do {
                try realm.write {
                    realm.delete(photoToDelete)
                }
            } catch {
                throw error
            }
        }
    }
    
    func isPhotoFavorite(id: String) async -> Bool {
        await MainActor.run {
            return realm.object(ofType: FavoritePhoto.self, forPrimaryKey: id) != nil
        }
    }
    
    func getFavoritePhotos() async -> [FavoritePhoto] {
        await MainActor.run {
            let favorites = realm.objects(FavoritePhoto.self).sorted(byKeyPath: "dateAdded", ascending: false)
            return Array(favorites)
        }
    }
}



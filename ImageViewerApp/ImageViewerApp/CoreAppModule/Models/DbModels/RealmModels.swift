//
//  RealmModels.swift
//  ImageViewerApp
//
//  Created by HarshM on 19/04/25.
//

import Foundation
import RealmSwift

class FavoritePhoto: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var width: Int = 0
    @Persisted var height: Int = 0
    @Persisted var color: String?
    @Persisted var photoDescription: String?
    @Persisted var altDescription: String?
    @Persisted var regularUrl: String?
    @Persisted var smallUrl: String?
    @Persisted var thumbUrl: String?
    @Persisted var downloadUrl: String?
    @Persisted var htmlUrl: String?
    @Persisted var likes: Int = 0
    @Persisted var userName: String?
    @Persisted var userFullName: String?
    @Persisted var userProfileImage: String?
    @Persisted var userLink: String?
    @Persisted var dateAdded: Date
    
    convenience init(from photo: UnsplashPhoto) {
        self.init()
        self.id = photo.id ?? UUID().uuidString
        self.width = photo.width ?? 0
        self.height = photo.height ?? 0
        self.color = photo.color
        self.photoDescription = photo.description
        self.altDescription = photo.altDescription
        self.regularUrl = photo.urls?.regular
        self.smallUrl = photo.urls?.small
        self.thumbUrl = photo.urls?.thumb
        self.downloadUrl = photo.links?.download
        self.htmlUrl = photo.links?.html
        self.likes = photo.likes ?? 0
        self.userName = photo.user?.username
        self.userFullName = photo.user?.name
        self.userProfileImage = photo.user?.profileImage?.medium
        self.userLink = photo.user?.links?.html
        self.dateAdded = Date()
    }
    
    func toUnsplashPhoto() -> UnsplashPhoto {
        let urls = PhotoURLs(
            raw: regularUrl,
            full: regularUrl,
            regular: regularUrl,
            small: smallUrl,
            thumb: thumbUrl,
            smallS3: nil
        )
        
        let links = PhotoLinks(
            _self: htmlUrl,
            html: htmlUrl,
            download: downloadUrl,
            downloadLocation: nil
        )
        
        let profileImage = ProfileImage(
            small: userProfileImage,
            medium: userProfileImage,
            large: userProfileImage
        )
        
        let userLinks = UserLinks(
            _self: userLink,
            html: userLink,
            photos: nil,
            likes: nil,
            portfolio: nil,
            following: nil,
            followers: nil
        )
        
        let user = UnsplashUser(
            id: userName,
            updatedAt: nil,
            username: userName,
            name: userFullName,
            firstName: nil,
            lastName: nil,
            twitterUsername: nil,
            portfolioUrl: nil,
            bio: nil,
            location: nil,
            links: userLinks,
            profileImage: profileImage,
            instagramUsername: nil,
            totalCollections: nil,
            totalLikes: nil,
            totalPhotos: nil,
            acceptedTos: nil,
            forHire: nil,
            social: nil
        )
        
        return UnsplashPhoto(
            id: id,
            createdAt: nil,
            updatedAt: nil,
            width: width,
            height: height,
            color: color,
            blurHash: nil,
            description: photoDescription,
            altDescription: altDescription,
            urls: urls,
            links: links,
            likes: likes,
            likedByUser: true,
            user: user,
            sponsorship: nil,
        )
    }
}



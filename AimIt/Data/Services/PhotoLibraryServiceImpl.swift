//
//  PhotoLibraryServiceImpl.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import Foundation
import PhotosUI

final class PhotoLibraryServiceImpl: PhotoLibraryService {
    func checkAuthorizationStatus() -> PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus(for: .readWrite)
    }
    
    func requestAuthorizationPermission() async -> PHAuthorizationStatus {
        return await PHPhotoLibrary.requestAuthorization(for: .readWrite)
    }
}

//
//  PhotoLibraryService.swift
//  AimIt
//
//  Created by Buzurg Rakhimzoda on 23.01.2025.
//

import Foundation
import PhotosUI

protocol PhotoLibraryService {
    func checkAuthorizationStatus() -> PHAuthorizationStatus
    
    func requestAuthorizationPermission() async -> PHAuthorizationStatus
}

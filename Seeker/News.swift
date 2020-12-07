//
//  News.swift
//  Seeker
//
//  Created by user178654 on 12/6/20.
//

import Foundation

import SwiftUI

struct News: Hashable, Codable, Identifiable {
    
    var id: Int
    var title: String
    var imageName: String
    var category: Category
    var bio: String
    var link: String
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case World = "World"
        case US = "US"
    }
    
}

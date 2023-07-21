//
//  UserModel.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 21/07/23.
//

import Foundation

struct UserModel: Codable {
    let page: Int
    let total: Int
    let total_pages: Int
    let data: [User]
}

struct User: Codable {
    let id: Int
    let name: String
    let year: Int
    let pantone_value: String
}


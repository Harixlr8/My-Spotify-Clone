//
//  Users.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import Foundation


struct UsersResponse: Codable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let username: String
    let image : String
    
    static var mock : User {
        User(
            id: 22,
            firstName: "Harikrishnan ",
            lastName: "S",
            email: "test@gmail.com",
            phone: "77778837773",
            username: "Xlr8999",
            image: Constants.randomImage
        )
    }

}



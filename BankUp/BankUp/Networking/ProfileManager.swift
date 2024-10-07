//
//  ProfileManager.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 7.10.2024.
//

import Foundation

protocol ProfileManagable {
//    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void)
}

enum NetworkError {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName  = "first_name"
        case lastName   = "last_name"
    }
}
 

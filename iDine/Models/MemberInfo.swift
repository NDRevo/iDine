//
//  Member.swift
//  iDine
//
//  Created by Noe Duran on 5/25/21.
//

import SwiftUI

struct MemberInfo: Codable, Equatable, Identifiable {
    
    var id: UUID?
    var email: String
    var password: String
    var isEmployee: Bool?
    var loyaltyNumber: Int?
    
    var favorites: [MenuItem] = []
}


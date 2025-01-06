//
//  User.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 06/01/2025.
//


import Foundation

// User Model
struct User: Codable {
    let id: String
    let email: String
    let password: String
    let name: String
    let phone: String
    let role: String
    let avatarURL: URL
    let isActive: Bool
    let lastLogin: Date
}

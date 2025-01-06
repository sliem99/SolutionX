//
//  LoginError.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 06/01/2025.
//


import Foundation

// Login Error Enum
enum LoginError: Error, LocalizedError {
    case invalidCredentials
    case userInactive
    case networkError
    case googleSignInCancelled

    var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "The email or password is incorrect."
        case .userInactive: return "The account is inactive. Please contact support."
        case .networkError: return "Network error occurred. Please try again later."
        case .googleSignInCancelled: return "Google sign-in was cancelled."
        }
    }
}

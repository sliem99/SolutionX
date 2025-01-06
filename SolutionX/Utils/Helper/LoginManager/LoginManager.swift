//
//  LoginManager.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 06/01/2025.
//


import Foundation

class LoginManager {
    static let shared = LoginManager()
    private var users: [User] = []

    init() {
        if let jsonData = MockUserDatabase.jsonString.data(using: .utf8) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                self.users = try decoder.decode([User].self, from: jsonData)
            } catch {
                print("Failed to decode mock users: \(error)")
            }
        }
    }

    func loginWithEmail(email: String, password: String, completion: @escaping (Result<User, LoginError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if let user = self.users.first(where: { $0.email == email && $0.password == password }) {
                if !user.isActive {
                    completion(.failure(.userInactive))
                } else {
                    completion(.success(user))
                }
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }

    func loginWithGoogle(completion: @escaping (Result<User, LoginError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            let isSuccess = Bool.random() // Randomize success or failure
            if isSuccess {
                // Simulate a Google user
                let googleUser = self?.users.randomElement() ?? self?.users[0]
                completion(.success(googleUser!))
            } else {
                let error = Bool.random() ? LoginError.googleSignInCancelled : LoginError.networkError
                completion(.failure(error))
            }
        }
    }
}

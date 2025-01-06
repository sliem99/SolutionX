//
//  StorageManager.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 06/01/2025.
//


import Foundation

class StorageManager<T: Codable> {
    private let storageKey: String

    init(storageKey: String) {
        self.storageKey = storageKey
    }

    func save(object: T) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(object)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save object: \(error)")
        }
    }

    func retrieve() -> T? {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Failed to retrieve object: \(error)")
            return nil
        }
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}

//
//  MockUserDatabase.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 06/01/2025.
//


import Foundation

struct MockUserDatabase {
    static let jsonString = """
    [
        {
            "id": "1",
            "email": "john.doe@example.com",
            "password": "password123",
            "name": "John Doe",
            "phone": "+1234567890",
            "role": "admin",
            "avatar_url": "https://example.com/avatar/john.jpg",
            "is_active": true,
            "last_login": "2025-01-05T14:23:00Z"
        },
        {
            "id": "2",
            "email": "jane.smith@example.com",
            "password": "mypassword",
            "name": "Jane Smith",
            "phone": "+1987654321",
            "role": "user",
            "avatar_url": "https://example.com/avatar/jane.jpg",
            "is_active": true,
            "last_login": "2025-01-04T10:15:30Z"
        },
        {
            "id": "3",
            "email": "emma.jones@example.com",
            "password": "securepass",
            "name": "Emma Jones",
            "phone": "+1123456789",
            "role": "moderator",
            "avatar_url": "https://example.com/avatar/emma.jpg",
            "is_active": false,
            "last_login": "2024-12-30T08:45:00Z"
        }
    ]
    """
}

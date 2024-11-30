//
//  UserService.swift
//  TechTest
//
//  Created by Jacob Bartlett on 14/11/2024.
//

import Factory
import Foundation

protocol UserService {
    
    /// Retrieves a new valid auth token from the
    /// server, then fetches the user data.
    ///
    func fetchUserInfo() async throws -> User
}

final class UserServiceImpl: UserService {

    @Injected(\.authService) private var authService
    
    private let userURL = URL(string: "https://jacobsapps.github.io/the-tech-test/Resources/user.json")!
    
    func fetchUserInfo() async throws -> User {
        let token = try await authService.getBearerToken()
        var request = URLRequest(url: userURL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try await URLSession.shared.data(for: request).0
        return try JSONDecoder().decode(User.self, from: data)
    }
}

extension Container {
    var userService: Factory<UserService> {
        Factory(self) { UserServiceImpl() }
    }
}

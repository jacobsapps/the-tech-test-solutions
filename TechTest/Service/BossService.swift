//
//  BossService.swift
//  TechTest
//
//  Created by Jacob Bartlett on 14/11/2024.
//

import Factory
import Foundation

protocol BossService {
    
    /// Retrieves a new valid auth token from the server, then fetches the boss data.
    ///
    func fetchBosses() async throws -> [Boss]
}

extension Container {
    var bossService: Factory<BossService> {
        Factory(self) { BossServiceImpl() }
    }
}

final class BossServiceImpl: BossService {
    
    @Injected(\.authService) private var authService
    
    private let bossURL = URL(string: "https://jacobsapps.github.io/the-tech-test/Resources/bosses.json")!
    
    func fetchBosses() async throws -> [Boss] {
        let token = try await authService.getBearerToken()
        var request = URLRequest(url: bossURL)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let data = try await URLSession.shared.data(for: request).0
        return try JSONDecoder().decode([Boss].self, from: data)
    }
}

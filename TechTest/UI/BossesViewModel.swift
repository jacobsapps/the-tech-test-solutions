//
//  BossesViewModel.swift
//  TechTest
//
//  Created by Jacob Bartlett on 14/11/2024.
//

import Combine
import Factory
import SwiftUI

final class BossesViewModel: ObservableObject {
    
    @Injected(\.userService) private var userService
    @Injected(\.bossService) private var bossService
    
    @Published private(set) var greeting: String = ""
    @Published private(set) var bosses: [Boss] = []
    @Published private(set) var likes: [Boss: Bool] = [:]
    
    @MainActor
    func load() async {
        do {
            async let user = userService.fetchUserInfo()
            async let bosses = bossService.fetchBosses()
            greeting = "Hello, \((try await user).firstName)"
            self.bosses = try await bosses
            
        } catch {
            print(error)
        }
    }

    func isLiked(_ boss: Boss) -> Bool {
        likes[boss] ?? false
    }
    
    func toggleLike(_ boss: Boss) {
        let isLiked = likes[boss] ?? false
        likes[boss] = !isLiked
    }
}

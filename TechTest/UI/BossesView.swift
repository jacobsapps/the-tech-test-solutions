//
//  BossesView.swift
//  TechTest
//
//  Created by Jacob Bartlett on 14/11/2024.
//

import SwiftUI

struct BossesView: View {
    
    @StateObject var viewModel = BossesViewModel()
    
    var body: some View {
        NavigationStack {
            let _ = Self._printChanges()
            List {
                ForEach(viewModel.bosses) { boss in
                    BossView(
                        boss: boss,
                        isLiked: viewModel.isLiked(boss),
                        toggleLike: {
                            viewModel.toggleLike(boss)
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.greeting)
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    BossesView()
}

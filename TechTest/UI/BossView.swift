//
//  BossView.swift
//  TechTest
//
//  Created by Jacob Bartlett on 14/11/2024.
//

import SwiftUI

struct BossView: View {
    
    let boss: Boss
    @State var isLiked: Bool
    let toggleLike: () -> Void
    
    var body: some View {
        let _ = Self._printChanges()
        HStack(spacing: 8) {
            AsyncImage(url: boss.imageURL, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            }, placeholder: {
                Color.black
            })
            .frame(width: 120, height: 120)
            .clipped()
            .cornerRadius(16)
            .overlay(alignment: .topLeading) {
                likeButton
            }

            bossDetails
        }
    }
    
    private var likeButton: some View {
        Button {
            isLiked.toggle()
            toggleLike()
            
        } label: {
            Image(systemName: "heart.fill")
                .resizable()
                .foregroundStyle(isLiked ? .red : .gray)
                .frame(width: 16, height: 16)
                .padding(8)
        }
    }
    
    private var bossDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(boss.name)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
            
            Text(boss.location)
                .font(.body)
                .foregroundStyle(.secondary)
            
            Text(boss.description)
                .font(.caption)
                .lineLimit(3, reservesSpace: true)
                .foregroundStyle(.primary)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

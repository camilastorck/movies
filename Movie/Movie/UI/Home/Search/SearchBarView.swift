//
//  SearchBarView.swift
//  Movies
//
//  Created by Camila Storck on 17/03/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchValue: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.title)
            
            TextField(text: $searchValue) {
                Text("SEARCH_PROMPT_TITLE".localized)
                    .foregroundStyle(.title)
                    .font(Font.medium(size: 15))
            }
            .onChange(of: searchValue) {
                isSearching = !searchValue.isEmpty
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
        )
        .background(Colors.background.color)
        .padding()
    }
}

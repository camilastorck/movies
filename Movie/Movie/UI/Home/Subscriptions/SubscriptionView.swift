//
//  SubscriptionsView.swift
//  Movies
//
//  Created by Camila Storck on 13/03/2024.
//

import SwiftUI
import MoviesService

struct SubscriptionsView: View {
    let movies: [MovieModel]
    let tapped: (MovieModel) -> Void
    private let row = [GridItem()]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("MOVIES_SUBSCRIPTION_TITLE".localized)
                .textCase(.uppercase)
                .font(Font.medium(size: 12))
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: row, spacing: 10) {
                    ForEach(movies) { movie in
                        Image(uiImage: movie.poster)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(4)
                            .frame(width: 110)
                            .onTapGesture {
                                tapped(movie)
                            }
                    }
                }
            }
            .frame(height: 160)
        }
        .padding()
    }
}

//
//  ListView.swift
//  Movies
//
//  Created by Camila Storck on 13/03/2024.
//

import SwiftUI
import MoviesService

struct ListView: View {
    let movies: [MovieModel]
    let tapped: (MovieModel) -> Void
    private let columns = [GridItem()]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 6) {
                Text("MOVIES_LIST_TITLE".localized)
                    .textCase(.uppercase)
                    .font(Font.medium(size: 12))
                
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(movies) { movie in
                        ZStack(alignment: .leading) {
                            Image(uiImage: movie.backdropImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(4)
                            
                            Color.black
                                .opacity(0.3)
                                .cornerRadius(4)
                            
                            HStack {
                                Text(movie.title)
                                    .font(Font.bold(size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.top, 100)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                VStack {
                                    Text(movie.genre)
                                        .textCase(.uppercase)
                                        .font(Font.medium(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 12)
                                        .background(.black.opacity(0.5))
                                        .cornerRadius(4)
                                }
                                .padding(
                                    .init(top: 0, leading: 0, bottom: 100, trailing: 12)
                                )
                            }
                        }
                        .onTapGesture {
                            tapped(movie)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

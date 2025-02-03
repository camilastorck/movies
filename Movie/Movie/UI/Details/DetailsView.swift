//
//  DetailsView.swift
//  Movies
//
//  Created by Camila Storck on 16/03/2024.
//

import SwiftUI

struct DetailsView: View {
    let viewModel: DetailsViewModel
    @State private var addTapped: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                    .opacity(0.7)
                
                VStack {
                    NavigationView() {
                        viewModel.dismiss()
                    }
                    
                    Image(uiImage: viewModel.movie.poster)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .cornerRadius(6)
                    
                    ScrollView {
                        Text(viewModel.movie.title)
                            .font(Font.bold(size: 20))
                            .foregroundStyle(.titleInverted)
                            .padding(.top)
                        
                        Text(viewModel.movie.year)
                            .font(Font.semibold(size: 16))
                            .foregroundStyle(.titleInverted)
                            .padding(.bottom)
                        
                        Button(addTapped ? "SUBSCRIBED".localized : "SUSCRIBE".localized) {
                            addTapped.toggle()
                            
                            if viewModel.isMovieSubscribed {
                                UsersDefaults.deleteFavoriteMovie(movie: viewModel.movie)
                            } else {
                                UsersDefaults.saveFavoriteMovie(movie: viewModel.movie)
                            }
                        }
                        .font(Font.semibold(size: 14))
                        .textCase(.uppercase)
                        .foregroundStyle(addTapped ? .yellow : .white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 10)
                        .background(addTapped ? .white : .white.opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.white, lineWidth: 2)
                        )
                        
                        VStack(alignment: .leading) {
                            Text("SUMMARY_TITLE".localized)
                                .font(Font.medium(size: 14))
                                .textCase(.uppercase)
                            
                            Text(viewModel.movie.overview)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.titleInverted)
                                .lineSpacing(6)
                                .font(Font.regular(size: 14))
                                .padding(.top, 2)
                        }
                        .padding(.vertical, 20)
                        .frame(width: geo.size.width * 0.85)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: geo.size.width)
            }
        }
        .onAppear {
            addTapped = viewModel.isMovieSubscribed
        }
    }
}

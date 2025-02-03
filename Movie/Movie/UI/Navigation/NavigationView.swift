//
//  NavigationView.swift
//  Movies
//
//  Created by Camila Storck on 17/03/2024.
//

import SwiftUI

struct NavigationView: View {
    let tapped: () -> Void
    
    var body: some View {
        HStack {
            NavigationButton {
                tapped()
            }
            Spacer()
        }
    }
}

struct NavigationButton: View {
    let tapped: () -> Void
    
    var body: some View {
        ZStack {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .frame(width: 14)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 9)
        .padding(.horizontal, 8)
        .background(.black)
        .cornerRadius(22)
        .onTapGesture {
            tapped()
        }
    }
}

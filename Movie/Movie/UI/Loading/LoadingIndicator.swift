//
//  LoadingIndicator.swift
//  Movie
//
//  Created by Camila Storck on 25/03/2024.
//

import SwiftUI

struct LoadingIndicator: View {
    @State private var degree: Int = 270
    @State private var spinnerLength: Double = 0.6
    
    var body: some View {
        ZStack{
            Circle()
                .trim(from: 0.0, to: spinnerLength)
                .stroke(
                    LinearGradient(
                        colors: [.yellow, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 6.5, lineCap: .round, lineJoin:.round)
                )
                .animation(.easeIn(duration: 1.5)
                    .repeatForever(autoreverses: true)
                )
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: Double(degree)))
                .animation(.linear(duration: 1)
                    .repeatForever(autoreverses: false)
                )
                .onAppear{
                    degree = 270 + 360
                    spinnerLength = 0
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

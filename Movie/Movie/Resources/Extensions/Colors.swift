//
//  Colors.swift
//  Movies
//
//  Created by Camila Storck on 22/03/2024.
//

import SwiftUI

enum Colors: String, CaseIterable {
    case background
    case title
    case titleInverted
}

extension Colors {
    var color: Color {
        Colors.allCases.contains(self) ? Color(self.rawValue, bundle: Bundle.main) : Color(.clear)
    }
}

//
//  Font+Extension.swift
//  Movies
//
//  Created by Camila Storck on 22/03/2024.
//

import SwiftUI

extension Font {
    static func regular(size: CGFloat) -> Font {
        Font.custom(ContentFont.regular.rawValue, size: size)
    }
    
    static func medium(size: CGFloat) -> Font {
        Font.custom(ContentFont.medium.rawValue, size: size)
    }
    
    static func semibold(size: CGFloat) -> Font {
        Font.custom(ContentFont.semibold.rawValue, size: size)
    }
    
    static func bold(size: CGFloat) -> Font {
        Font.custom(ContentFont.bold.rawValue, size: size)
    }
}

enum ContentFont: String {
    case regular = "MontserratRoman-Regular"
    case medium = "MontserratRoman-Medium"
    case semibold = "MontserratRoman-SemiBold"
    case bold = "MontserratRoman-Bold"
}

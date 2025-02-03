//
//  String+Extension.swift
//  Movies
//
//  Created by Camila Storck on 22/03/2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized(_ args: CVarArg...) -> String {
        String(format: localized, locale: Locale.current, arguments: args)
    }
}

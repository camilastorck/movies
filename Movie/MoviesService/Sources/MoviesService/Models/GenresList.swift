//
//  GenresList.swift
//
//  Created by Camila Storck on 22/03/2024.
//

struct GenreList: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

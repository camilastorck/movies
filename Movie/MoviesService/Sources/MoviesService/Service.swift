//
//  Service.swift
//  Movie
//
//  Created by Camila Storck on 20/03/2024.
//

import Foundation

@available(iOS 13.0.0, *)
public protocol ServiceProtocol {
    func getMovies(type: MovieType) async -> Result<MoviesResponseModel, ServiceError>
    func searchMovie(query: String) async -> Result<MoviesResponseModel, ServiceError>
}

@available(iOS 13.0.0, *)
public final class Service: ServiceProtocol {
    
    public init() { }
    
    private let endpoint = "https://api.themoviedb.org/3"
    private let apiKey = ""
    
    public func getMovies(type: MovieType) async -> Result<MoviesResponseModel, ServiceError> {
        do {
            let movies = try await getMoviesList(type: type)
            let genreList = try await getGenresList()
            
            let result = MoviesResponseModel.build(movies: movies, genres: genreList.genres)
            return .success(result)
        } catch {
            return .failure(error as? ServiceError ?? .unexpectedError)
        }
    }
    
    public func searchMovie(query: String) async -> Result<MoviesResponseModel, ServiceError> {
        do {
            let genreList = try await getGenresList()
            let response = try await getSearchResults(query: query)
            
            let result = MoviesResponseModel.build(movies: response, genres: genreList.genres)
            return .success(result)
        } catch {
            return .failure(error as? ServiceError ?? .unexpectedError)
        }
    }
    
    private func getMoviesList(type: MovieType) async throws -> MoviesResponse {
        let endpoint = "\(endpoint)/movie/\(type.rawValue)?api_key=\(apiKey)&page=1&language=en-US"
        guard let url = URL(string: endpoint) else {
            throw ServiceError.urlNotFound
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MoviesResponse.self, from: data)
    }
    
    private func getSearchResults(query: String) async throws -> MoviesResponse {
        let endpoint = "\(endpoint)/search/movie?api_key=\(apiKey)&query=\(query)&page=1&language=en-US"
        guard let url = URL(string: endpoint) else {
            throw ServiceError.urlNotFound
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MoviesResponse.self, from: data)
    }
    
    private func getGenresList() async throws -> GenreList {
        let endpoint = "\(endpoint)/genre/movie/list?api_key=\(apiKey)"
        guard let url = URL(string: endpoint) else {
            throw ServiceError.urlNotFound
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GenreList.self, from: data)
    }
    
}

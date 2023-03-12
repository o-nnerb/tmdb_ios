//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import MoviesData
import Injection

public struct MoviesLocalDataSource {

    public init() {}
}

extension MoviesLocalDataSource: MoviesData.MoviesLocalDataSource {

    public func getGenre(_ id: Int) throws -> GenreResponseDTO {
        let data = UserDefaults.standard.data(forKey: "genres")
        let genres = try JSONDecoder().decode([GenreResponseDTO].self, from: data ?? Data())

        guard let genre = genres.first(where: { $0.id == id }) else {
            throw NSError(domain: "Not found", code: -1)
        }

        return genre
    }

    public func setGenres(_ genres: [GenreResponseDTO]) throws {
        let data = try JSONEncoder().encode(genres)
        UserDefaults.standard.set(data, forKey: "genres")
    }

    public func setPhoto(_ image: Data, forPath path: String) throws {
        let fileManager = FileManager.default
        let tempURL = fileManager.temporaryDirectory.appending(path: "tmdb_images")

        if !fileManager.fileExists(atPath: tempURL.path()) {
            try fileManager.createDirectory(at: tempURL, withIntermediateDirectories: true)
        }

        try image.write(to: tempURL.appending(path: "\(path).png"))
    }

    public func getPhoto(_ path: String) throws -> Data {
        let fileManager = FileManager.default
        let tempURL = fileManager.temporaryDirectory.appending(path: "tmdb_images")
        return try .init(contentsOf: tempURL.appending(path: "\(path).png"))
    }
}

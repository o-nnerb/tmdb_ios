//
//  File.swift
//  
//
//  Created by Brenno on 20/02/23.
//

import Foundation
import Injection

public protocol GetPhotoUseCaseProtocol {

    func callAsFunction(_ path: String) async throws -> Data
}

public struct GetPhotoUseCase {

    @Injected var repository: MoviesRepositoryProtocol

    public init() {}
}

extension GetPhotoUseCase: GetPhotoUseCaseProtocol {

    public func callAsFunction(_ path: String) async throws -> Data {
        try await repository.getPhoto(for: path)
    }
}

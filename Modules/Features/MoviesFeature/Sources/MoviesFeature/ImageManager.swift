//
//  File.swift
//  
//
//  Created by Brenno on 01/03/23.
//

import Foundation
import CoreKit
import Injection

private enum Loading {
    case task(Task<Data, Error>)
    case completed
    case failed
}

class ImageManager {

    @Injected var getPhotoUseCase: GetPhotoUseCaseProtocol

    static let shared = ImageManager()

    private var loadingPhotos: [String: Loading] = [:]

    func getPhoto(_ path: String) async throws -> Data {
        switch loadingPhotos[path] {
        case .completed:
            return try await getPhotoUseCase(path)
        case .task(let task):
            return try await task.value
        case .none, .failed:
            let task = Task {
                do {
                    let data = try await getPhotoUseCase(path)
                    self.loadingPhotos[path] = .completed
                    return data
                } catch {
                    loadingPhotos[path] = .failed
                    throw error
                }
            }
            loadingPhotos[path] = .task(task)
            return try await task.value

        }
    }
}

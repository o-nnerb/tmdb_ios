//
//  Injected.swift
//  
//
//  Created by Brenno Giovanini de Moura on 03/11/22.
//

import Foundation

@propertyWrapper
public struct Injected<Object> {

    public init(_ container: Container = .shared) {
        wrappedValue = container.resolve(forKey: Object.self)
    }

    public let wrappedValue: Object
}

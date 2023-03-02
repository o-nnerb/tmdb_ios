//
//  Container.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation

public class Container {

    public static let shared = Container()

    private var table: [AnyHashable: Box] = [:]

    public func register<Object>(
        _ object: @escaping () -> Object,
        forKey key: Object.Type,
        options: Options = .weak
    ) {
        table[ObjectIdentifier(key)] = .init(options) { object() as AnyObject }
    }

    public func resolve<Object>(forKey key: Object.Type) -> Object {
        guard
            let box = table[ObjectIdentifier(key)],
            let object = box() as? Object
        else { fatalError("Can't find \(key)") }

        return object
    }
}

extension Container {

    public enum Options {
        case weak
        case strong
    }

    class Box {
        private let factory: () -> AnyObject

        init(_ options: Options, _ factory: @escaping () -> AnyObject) {
            switch options {
            case .strong:
                self.factory = Self.strongBlock(factory)
            case .weak:
                self.factory = Self.weakBlock(factory)
            }
        }

        static func weakBlock(_ factory: @escaping () -> AnyObject) -> () -> AnyObject {
            weak var object: AnyObject?
            return {
                if let object {
                    return object
                }

                let newValue = factory()
                object = newValue
                return newValue
            }
        }

        static func strongBlock(_ factory: @escaping () -> AnyObject) -> () -> AnyObject {
            var object: AnyObject?
            return {
                if let object {
                    return object
                }

                let newValue = factory()
                object = newValue
                return newValue
            }
        }

        func callAsFunction() -> AnyObject {
            factory()
        }
    }
}

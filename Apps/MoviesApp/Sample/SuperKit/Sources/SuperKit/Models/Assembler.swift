//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation
import Injection

@MainActor
public enum Assembler {

    static func run(
        _ assemblies: [Assembly],
        in container: Container = .shared
    ) {
        for assembly in assemblies {
            assembly.assemble(container: container)
        }
    }
}

//
//  Assembler.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection

enum Assembler {
    static func run(
        _ assemblies: [Assembly],
        in container: Container = .shared
    ) {
        for assembly in assemblies {
            assembly.assemble(container: container)
        }
    }
}

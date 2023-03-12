//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import Foundation
import Injection

@MainActor
public protocol Assembly {

    func assemble(container: Container)
}

//
//  Assembly.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation
import Injection

protocol Assembly {
    func assemble(container: Container)
}

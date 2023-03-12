//
//  PantryApp.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SuperKit

public enum MoviesApp: App {

    public static func start() {
        Assembler.run([
            DomainAssembly(),
            DataAssembly(),
            NetworkingAssembly(),
            StorageAssembly()
        ])
    }
}

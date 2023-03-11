//
//  PantryApp.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import SwiftUI
import CoreApp
import CoreScene

public enum TMDbApp {

    public static func start() {
        Assembler.run([
            CoreKitAssembly(),
            DataKitAssembly(),
            CoreNetworkAssembly(),
            CoreStorageAssembly()
        ])
    }
}

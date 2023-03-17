//
//  Bool+Debug.swift
//  
//
//  Created by Brenno Giovanini de Moura on 04/11/22.
//

import Foundation

extension Bool {

    static var debugEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}

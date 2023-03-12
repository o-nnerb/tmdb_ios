//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI

extension View {

    public func eraseToAnyView() -> AnyView {
        .init(self)
    }
}

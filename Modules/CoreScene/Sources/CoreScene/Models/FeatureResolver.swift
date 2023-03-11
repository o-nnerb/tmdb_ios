//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI

@MainActor
public protocol FeatureResolver: View {

    associatedtype Scene: Hashable

    init(_ scene: Scene)
}

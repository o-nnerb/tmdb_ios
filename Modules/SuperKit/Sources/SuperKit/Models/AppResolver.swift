//
//  File.swift
//  
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI

@MainActor
public protocol AppResolver: View {

    associatedtype Scene: Hashable

    init(_ scene: Scene)
}

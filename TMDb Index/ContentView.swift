//
//  ContentView.swift
//  TMDb Index
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import NavigationKit
import CoreScene
import TMDbApp

struct ContentView: View {

    @Environment(\.viewResolver) var viewResolver

    var body: some View {
        viewResolver(TMDbAppScene.start)
    }
}

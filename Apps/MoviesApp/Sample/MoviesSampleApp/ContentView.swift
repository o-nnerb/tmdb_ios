//
//  ContentView.swift
//  MoviesSampleApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import NavigationKit
import SuperKit

struct ContentView: View {

    @Environment(\.viewResolver) var viewResolver

    var body: some View {
        viewResolver(MoviesAppScene.movies(.init()))
    }
}

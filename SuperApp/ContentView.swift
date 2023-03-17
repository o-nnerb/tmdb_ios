//
//  ContentView.swift
//  SuperApp
//
//  Created by Brenno on 12/03/23.
//

import SwiftUI
import SuperKit

struct ContentView: View {

    @Environment(\.viewResolver) var viewResolver

    var body: some View {
        viewResolver(MoviesAppScene.movies(
            MoviesAppScene.Movies()
        ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

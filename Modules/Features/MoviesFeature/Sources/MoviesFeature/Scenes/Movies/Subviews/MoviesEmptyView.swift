//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI

struct MoviesEmptyView: View {

    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 16) {
            Text(title)
            Text(description)
        }
    }
}

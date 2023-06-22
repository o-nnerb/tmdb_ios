//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI

struct BackButton: View {

    let action: () -> Void

    init(_ action: @escaping () -> Void) {
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                Text("Back")
            }
        }
    }
}

//
//  File.swift
//  
//
//  Created by Brenno on 28/02/23.
//

import SwiftUI

struct LazyImage: View {

    private let image: CGImage?
    private let label: Text
    private let isLoading: Bool

    init(
        image: CGImage?,
        label: Text,
        isLoading: Bool
    ) {
        self.image = image
        self.label = label
        self.isLoading = isLoading
    }

    var body: some View {
        ZStack {
            Color.gray

            Group {
                if isLoading {
                    ProgressView()
                } else if let image {
                    Image(
                        image,
                        scale: 1.0,
                        label: label
                    )
                    .resizable()
                }
            }
        }
    }
}

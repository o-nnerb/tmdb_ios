//
//  File.swift
//  
//
//  Created by Brenno on 11/03/23.
//

import SwiftUI
import CoreScene
import NavigationKit
import CoreApp

struct ErrorViewModifier: ViewModifier {

    @State var isPresenting: Bool = false
    @State var action: ErrorSceneAction?

    func body(content: Content) -> some View {
        content
            .alert(
                "Error",
                isPresented: $isPresenting,
                presenting: action?.scene.error,
                actions: { _ in
                    Button("Ok") {}
                },
                message: {
                    Text($0.localizedDescription)
                }
            )
            .sceneAction(for: ErrorSceneAction.self) {
                action = $0
            }
            .onChange(of: isPresenting) {
                if !$0 {
                    action = nil
                }
            }
            .onChange(of: action) {
                if $0 != nil {
                    isPresenting = true
                }
            }
    }
}

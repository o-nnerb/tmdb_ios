//
//  ErrorCoordinator.swift
//  
//
//  Created by Brenno Giovanini de Moura on 03/11/22.
//

import SwiftUI
import CoreApp
import CoreKit
import CoreScene
import Injection

struct ErrorModifier: ViewModifier {

    @Environment(\.sceneAction) var sceneAction

    @Binding var action: ErrorAction?
    @State var isPresenting: Bool = false

    func body(content: Content) -> some View {
        content
            .alert(
                "Error",
                isPresented: $isPresenting,
                presenting: action?.error,
                actions: { _ in
                    Button("Ok") {}
                },
                message: {
                    Text($0.localizedDescription)
                }
            )
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

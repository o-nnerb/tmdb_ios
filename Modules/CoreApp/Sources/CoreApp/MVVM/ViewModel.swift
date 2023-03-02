//
//  ViewModel.swift
//  
//
//  Created by Brenno Giovanini de Moura on 03/11/22.
//

import Foundation
import Combine

@MainActor
open class ViewModel<Destination> {

    @Published public var destination: Destination?

    public var cancellations: [AnyCancellable]

    public init() {
        self.cancellations = []
        setBindings()
    }

    open func setBindings() {}
}

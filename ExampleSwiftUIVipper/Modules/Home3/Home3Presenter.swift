// 
//  Home3Presenter.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import SwiftUI

class Home3Presenter: VTPHome3Protocol {

    var view: PTVHome3Protocol?
    var interactor: PTIHome3Protocol?
    var router: PTRHome3Protocol?
    
    @Published var states: Home3Entity = Home3Entity()
    
    func getItems() {
        setState { prevValue in
            prevValue.isFetchData = true
        }
        interactor?.fetchData()
    }
}

extension  Home3Presenter : ITPHome3Protocol {
    func setState(_ updater: (inout Home3Entity) -> Void) {
        var newState = states
        updater(&newState)
        states = newState
    }
    
    func onFetchData(items: [[String: String]]) {
        setState { prevValue in
            prevValue.isFetchData = false
            prevValue.items = items
        }
        
    }
}

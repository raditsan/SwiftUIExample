// 
//  Home2Presenter.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

class Home2Presenter: VTPHome2Protocol {

    var view: PTVHome2Protocol?
    var interactor: PTIHome2Protocol?
    var router: PTRHome2Protocol?
    
    @Published var states: Home2Entity = Home2Entity()
    
    func getItems() {
        setState { prevValue in
            prevValue.isFetchData = true
        }
        interactor?.fetchData()
    }
}

extension  Home2Presenter : ITPHome2Protocol {
    func setState(_ updater: (inout Home2Entity) -> Void) {
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

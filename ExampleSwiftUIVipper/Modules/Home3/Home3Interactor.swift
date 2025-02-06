// 
//  Home3Interactor.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import Foundation

class Home3Interactor: PTIHome3Protocol {
    
    var presenter: ITPHome3Protocol

    init(presenter: ITPHome3Protocol) {
        self.presenter = presenter
    }
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let items = [
                ["id": "1", "name": "Item 1"],
                ["id": "2", "name": "Item 2"],
            ]
            self.presenter.onFetchData(items: items)
        }
    }
}

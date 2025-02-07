// 
//  Home2Interactor.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import Foundation

class Home2Interactor: PTIHome2Protocol {
    
    var presenter: ITPHome2Protocol

    init(presenter: ITPHome2Protocol) {
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

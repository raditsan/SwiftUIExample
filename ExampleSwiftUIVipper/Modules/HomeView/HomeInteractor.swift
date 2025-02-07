//
//  HomeInteractor.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

class HomeInteractor: HomeInteractorProtocol {
    var presenter: (any HomePresenterProtocol)?
    
    func fetchItems() {
        let items = Modules().list
        presenter?.didFetchItems(items)
    }
}

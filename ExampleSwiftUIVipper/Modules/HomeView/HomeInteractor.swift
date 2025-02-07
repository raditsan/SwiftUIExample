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
        let items = [
            HomeItemEntity(name: "Combine Architect (List, Refresh, Load More)", destination: AnyView(Home4View())),
            HomeItemEntity(name: "Viper Architect", destination: AnyView(Home2Router.createModule())),
        ]
        presenter?.didFetchItems(items)
    }
}

//
//  HomePresenter.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    @Published var items: [HomeItemEntity] = []
    
    func getItems() {
        interactor?.fetchItems()
    }
    
    func didFetchItems(_ items: [HomeItemEntity]) {
        self.items = items
    }
    
    func pushToDetail(param: HomeItemEntity) {
        router?.navigateToDetail(param: param)
    }
}

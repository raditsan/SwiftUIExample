//
//  HomeProtocol.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

protocol HomePresenterProtocol: ObservableObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    // From View to Presenter
    func getItems()
    func pushToDetail(param: HomeItemEntity)
    
    // From Interactor to Presenter
    func didFetchItems(_ items: [HomeItemEntity])
}

protocol HomeViewProtocol {
    // From Presenter to View
    func showItems(_ items: [HomeItemEntity])
}

protocol HomeInteractorProtocol {
    // From Presenter to Interactor
    func fetchItems()
}

protocol HomeRouterProtocol {
    // Initial View (must call to show the View have Viper)
    static func createModule() -> HomeView
    
    // From Presenter to Router
    func navigateToDetail(param: HomeItemEntity)
}

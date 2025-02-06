//
//  HomeRouter.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

class HomeRouter: HomeRouterProtocol {
    var view: HomeView?
    
    static func createModule() -> HomeView {
        let presenter = HomePresenter()
        let view = HomeView(presenter: presenter)
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        return view
    }
    
    func navigateToDetail(param: HomeItemEntity) {
        print("param", param)
//        let detailView = HomeDetailView(param: param)
//        if let viewController = viewController {
//            // In SwiftUI, navigation is handled differently. You can use NavigationLink or a coordinator pattern.
//            // For simplicity, we'll just print the navigation action.
//            print("Navigate to detail with param: \(param)")
//        }
    }
}

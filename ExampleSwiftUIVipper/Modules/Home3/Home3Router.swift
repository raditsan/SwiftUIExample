// 
//  Home3Router.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import UIKit

class Home3Router: PTRHome3Protocol {
    
    static func createModule() -> Home3View {
        let presenter =  Home3Presenter()
        let view =  Home3View(presenter: presenter)
        let interactor =  Home3Interactor(presenter: presenter)
        let router =  Home3Router()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        return view
    }
}

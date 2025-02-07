// 
//  Home2Router.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import UIKit

class Home2Router: PTRHome2Protocol {
    
    static func createModule() -> Home2View {
        let presenter =  Home2Presenter()
        let view =  Home2View(presenter: presenter)
        let interactor =  Home2Interactor(presenter: presenter)
        let router =  Home2Router()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        return view
    }
}

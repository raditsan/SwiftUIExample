// 
//  Home3Protocol.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import UIKit

protocol VTPHome3Protocol: ObservableObject {
    var view: PTVHome3Protocol? { get set }
    var interactor: PTIHome3Protocol? { get set }
    var router: PTRHome3Protocol? { get set }
    var states: Home3Entity { get set }
    func getItems()
}

protocol PTVHome3Protocol {
    
}

protocol PTIHome3Protocol: AnyObject {
    var presenter: ITPHome3Protocol { get }
    func fetchData()

}

protocol ITPHome3Protocol: AnyObject {
    func setState(_ updater: (inout Home3Entity) -> Void)
    func onFetchData(items: [[String: String]])
}

protocol PTRHome3Protocol: AnyObject {
    
}

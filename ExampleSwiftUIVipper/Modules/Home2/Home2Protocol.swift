// 
//  Home2Protocol.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import UIKit

protocol VTPHome2Protocol: ObservableObject {
    var view: PTVHome2Protocol? { get set }
    var interactor: PTIHome2Protocol? { get set }
    var router: PTRHome2Protocol? { get set }
    var states: Home2Entity { get set }
    func getItems()
}

protocol PTVHome2Protocol {
    
}

protocol PTIHome2Protocol: AnyObject {
    var presenter: ITPHome2Protocol { get }
    func fetchData()

}

protocol ITPHome2Protocol: AnyObject {
    func setState(_ updater: (inout Home2Entity) -> Void)
    func onFetchData(items: [[String: String]])
}

protocol PTRHome2Protocol: AnyObject {
    
}

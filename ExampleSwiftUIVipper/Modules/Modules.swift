//
//  Modules.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 07/02/25.
//

import SwiftUI

class Modules {
    let list = [
        HomeItemEntity(name: "Combine Architect (List, Refresh, Load More)", destination: AnyView(Home4View())),
        HomeItemEntity(name: "Viper Architect", destination: AnyView(Home2Router.createModule())),
        HomeItemEntity(name: "Modal, Alert, Context Menu", destination: AnyView(Example3View())),
    ]
}

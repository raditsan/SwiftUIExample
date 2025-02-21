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
        HomeItemEntity(name: "Example 3: Modal, Alert, Context Menu", destination: AnyView(Example3View())),
        HomeItemEntity(name: "Example 4: Global, Global Modal", destination: AnyView(Example4View())),
        HomeItemEntity(name: "Example 5: MVVM Architect", destination: AnyView(Example5View())),
        HomeItemEntity(name: "Example 6: Button Component", destination: AnyView(Example6View())),
        HomeItemEntity(name: "Example 7: Local Notification", destination: AnyView(Example7View())),
        HomeItemEntity(name: "Example 8: Select Option Component", destination: AnyView(Example8View())),
        HomeItemEntity(name: "Example 9: Checkbox Component", destination: AnyView(Example9View())),
        HomeItemEntity(name: "Example 10: Number TextField Component", destination: AnyView(Example10View())),
        HomeItemEntity(name: "Example 11: Mvvm Moya request", destination: AnyView(Example11View())),
        HomeItemEntity(name: "Example 12: Grid View", destination: AnyView(Example12View())),
        HomeItemEntity(name: "Example 13: Morp, FullScreen", destination: AnyView(Example13View())),
        HomeItemEntity(name: "Example 14: GeometryReader", destination: AnyView(Example14View())),
        HomeItemEntity(name: "Example 15: Atom Design", destination: AnyView(Example15View())),
        HomeItemEntity(name: "Example 16: Animation", destination: AnyView(Example16View())),
    ]
}

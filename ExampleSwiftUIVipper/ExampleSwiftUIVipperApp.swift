//
//  ExampleSwiftUIVipperApp.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

@main
struct ExampleSwiftUIVipperApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            HomeRouter.createModule()
//            Home2Router.createModule()
        }
    }
}

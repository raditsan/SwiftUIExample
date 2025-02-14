//
//  ContentView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                Image(systemName: "globe")
//                    .imageScale(.large)
//                    .foregroundStyle(.tint)
//                Text("Hello, world!")
//                NavigationLink(destination: HomeDetailView()) {
//                    Text("Detail")
//                }
//            }
//            .padding()
//            .navigationTitle("Conten View")
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}


//struct RootView: View {
//    @StateObject var modalManager = ModalManager() // Create modal manager here
//
//    var body: some View {
//        NavigationView {
//            ParentView()
//                .environmentObject(modalManager) // Pass down to all views
//        }
//    }
//}

struct ParentView: View {
    @EnvironmentObject var modalManager: ModalManager // Receive the manager

    var body: some View {
        VStack {
            NavigationLink("Go to Second", destination: SecondView())
        }
        .overlay(GlobalModalView().environmentObject(modalManager)) // Ensure modal listens
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            NavigationLink("Go to Third", destination: ThirdView())
        }
    }
}

struct ThirdView: View {
    @EnvironmentObject var modalManager: ModalManager // Get shared modal manager

    var body: some View {
        VStack {
            Text("Third View")
            
            Button("Show Modal") {
                modalManager.showModal {
                    VStack {
                        Text("Custom Modal")
                            .font(.headline)
                        Button("Close") {
                            modalManager.hideModal()
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
}

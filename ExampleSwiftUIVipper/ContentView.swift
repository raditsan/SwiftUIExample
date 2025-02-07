//
//  ContentView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                NavigationLink(destination: HomeDetailView()) {
                    Text("Detail")
                }
            }
            .padding()
            .navigationTitle("Conten View")
        }
    }
}

#Preview {
    ContentView()
}

// 
//  Home3View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//
import SwiftUI

struct Home3View: View {
    @ObservedObject var presenter: Home3Presenter
    
    var body: some View {
        VStack {
            if !presenter.states.isFetchData {
                List(presenter.states.items, id: \.self) { dict in
                    Button(action: {
                        print("Click \(dict)")
                    }, label: {
                        Text(dict["name"]!)
                    })
                }
            } else {
                ProgressView("Fetching data...")
            }
        }
        .onAppear {
            print("Home3View onAppear")
            presenter.getItems()
        }
        .onDisappear {
            print("Home3View onDisappear")
        }
        .onChange(of: presenter.states.items) { newValue in
            print("states.items", newValue)
        }
        .onChange(of: presenter.states.isFetchData) { newValue in
            print("states.isFetchData", newValue)
        }
        .navigationTitle("Home3")
    }

}

extension Home3View: PTVHome3Protocol {
    
}

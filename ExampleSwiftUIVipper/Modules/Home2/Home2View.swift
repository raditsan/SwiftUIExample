// 
//  Home2View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//
import SwiftUI

struct Home2View: View {
    @ObservedObject var presenter: Home2Presenter
    
    var body: some View {
        VStack {
            if !presenter.states.isFetchData {
                List(presenter.states.items, id: \.self) { dict in
                    NavigationLink(destination: Home3Router.createModule()) {
                        Text(dict["name"]!)
                    }
//                        Button(action: {
//                            print("Click \(dict)")
//                        }, label: {
//                            Text(dict["name"]!)
//                        })
                }
            } else {
                ProgressView("Fetching data...")
            }
        }
        .onAppear {
            presenter.getItems()
        }
        .onChange(of: presenter.states.items) { newValue in
            print("states.items", newValue)
        }
        .onChange(of: presenter.states.isFetchData) { newValue in
            print("states.isFetchData", newValue)
        }
    }
}

extension Home2View: PTVHome2Protocol {}

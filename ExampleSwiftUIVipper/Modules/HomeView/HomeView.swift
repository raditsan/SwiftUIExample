//
//  HomeView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        NavigationView {
            List(presenter.items, id: \.id) { item in
                NavigationLink(
                    destination: item.destination
                                    .navigationTitle(item.name)
                ) {
                   Text(item.name)
                        .font(.headline)
               }
//                Button(action: {
//                    presenter.pushToDetail(param: item)
//                }) {
//                    Text(item.name)
//                }
            }
            .onAppear {
                presenter.getItems()
            }
            .navigationTitle("Home")
            
        }
        
    }
}

extension HomeView: HomeViewProtocol {
    func showItems(_ items: [HomeItemEntity]) {
        
    }
}

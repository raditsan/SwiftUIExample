//
//  ContentView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import SwiftUI

struct Home4View: View {
    @ObservedObject var viewModel = Home4ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.body)
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        viewModel.selectedPost = post
                    }
                }
                
                if viewModel.isLoading && !viewModel.isRefreshing {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                
                if viewModel.canLoadMore && !viewModel.isLoading {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.loadMorePosts()
                        }) {
                            Text("Load More")
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Posts")
            .refreshable {
                viewModel.refreshPosts()
            }
            .overlay(
                Group {
                    if viewModel.isRefreshing {
                        ProgressView()
                    }
                }
            )
            .alert(item: $viewModel.selectedPost) { post in
                Alert(
                    title: Text(post.title),
                    message: Text(post.body),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct Home4View_Previews: PreviewProvider {
    static var previews: some View {
        Home4View()
    }
}

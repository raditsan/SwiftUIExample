//
//  PostViewModel.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 06/02/25.
//

import SwiftUI
import Combine

class Home4ViewModel: ObservableObject {
    @Published var posts: [Home4Model] = []
    @Published var isLoading = false
    @Published var isRefreshing = false
    @Published var canLoadMore = true
    @Published var selectedPost: Home4Model? = nil
    
    private var currentPage = 1
    private var totalPage = 10
    private var cancellable: AnyCancellable?
    
    init() {
        fetchPosts()
    }
    
    deinit {
        if isLoading || isRefreshing {
            cancellable?.cancel()
        }
    }
    
    func fetchPosts() {
        guard !isLoading else { return }
        
        isLoading = true
        let urlString = "https://jsonplaceholder.typicode.com/posts?_page=\(currentPage)&_limit=\(totalPage)"
        
        guard let url = URL(string: urlString) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Home4Model].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fetchedPosts in
                self?.isLoading = false
                self?.isRefreshing = false
                self?.posts.append(contentsOf: fetchedPosts)
                self?.canLoadMore = !fetchedPosts.isEmpty
                self?.currentPage += 1
            }
    }
    
    func refreshPosts() {
        guard !isRefreshing else { return }
        isRefreshing = true
        currentPage = 1
        posts.removeAll()
        fetchPosts()
    }
    
    func loadMorePosts() {
        guard !isLoading, canLoadMore else { return }
        fetchPosts()
    }
}

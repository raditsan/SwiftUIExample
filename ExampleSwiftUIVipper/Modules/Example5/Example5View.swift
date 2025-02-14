//
//  Example5View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 12/02/25.
//

import SwiftUI

struct Example5View: View {
    @StateObject private var viewModel = Example5ViewModel()
    
    var body: some View {
        List(viewModel.users) { user in
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text("\(user.age)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
    }
    
}

#Preview {
    Example5View()
}

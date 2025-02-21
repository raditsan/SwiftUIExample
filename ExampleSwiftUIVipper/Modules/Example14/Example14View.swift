//
//  Example14View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//

import SwiftUI

struct Example14View: View {
    @State var textSizeInside: CGSize = CGSize()
    @State var textSizeOutsize: CGSize = CGSize()
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("textSizeInside \(textSizeInside)\ntextSizeOutsize \(textSizeOutsize)")
                    .background(
                        GeometryReader { proxy in
                            Color.clear // Invisible background
                                .onAppear {
                                    textSizeInside = proxy.size
                                }
                        }
                    )
                    .onAppear {
                        textSizeOutsize = geometry.size
                    }
            }
        }
    }
}

#Preview {
    NavigationView {
        Example14View()
    }
    .navigationTitle("Test")
}

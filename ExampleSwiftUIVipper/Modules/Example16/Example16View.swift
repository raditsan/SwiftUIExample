//
//  Example16View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 20/02/25.
//

import SwiftUI

struct Example16View: View {
    @State private var isShow: Bool = false
    var card: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 80, height: 80)
        }
        .frame(maxWidth: .infinity)
    }
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isShow.toggle()
                }
            }) {
                Text("Show")
                Label("Graph", systemImage: "chevron.right.circle")
                    .labelStyle(.iconOnly)
                    .imageScale(.large)
                    .rotationEffect(.degrees(isShow ? 90 : 0))
                    .scaleEffect(isShow ? 1.5 : 1)
                    .padding()
                    .animation(.easeInOut, value: isShow)
            }
            
            
            ScrollView {
                VStack {
                    if isShow {
                        card
                            .transition(.move(edge: .trailing))
                        card
                            .transition(.move(edge: .leading))
                        card
                            .transition(.opacity)
                        card
                            .transition(.scale)
                        card
                            .transition(.slide)
                        card
                            .transition(.offset(x: 0, y: -100))
                        card
                            .transition(.offset(x: -100, y: -100))
                        if #available(iOS 16.0, *) {
                            card
                                .transition(.push(from: Edge.trailing))
                                .background(Color(.red))
                        }
                        
                        VStack {
                            Text("Im Detail")
                                .foregroundStyle(Color(.white))
                        }
                        .background(Color(.blue))
                       
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        
    }
}

#Preview {
    Example16View()
}

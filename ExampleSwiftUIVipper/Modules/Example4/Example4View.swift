//
//  Example4View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 07/02/25.
//

import SwiftUI

@MainActor
class ModalManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var content: AnyView = AnyView(EmptyView())
    @Published var allowDismiss: Bool = true // Controls whether tapping outside closes the modal

    static let shared = ModalManager() // Singleton instance

    private init() {}

    func showModal<Content: View>(allowDismiss: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = AnyView(content())
        self.allowDismiss = allowDismiss
        self.isShowing = true
    }

    func hideModal() {
        self.isShowing = false
    }
}

struct GlobalModalView: View {
    @ObservedObject var modalManager = ModalManager.shared

    var body: some View {
        ZStack {
            if modalManager.isShowing {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        if modalManager.allowDismiss {
                            modalManager.hideModal()
                        }
                    }

                modalManager.content
                    .frame(width: 300, height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .animation(.easeInOut, value: modalManager.isShowing)
    }
}

struct Example4View: View {
    @Environment(\.alerterKey) var theAlerter
    var body: some View {
        ZStack {
            VStack {
                NavigationLink("Go to Second", destination: Example4SecondView())
                Button("Show Modal") {
                    theAlerter.showAlert = true
                }
            }
            GlobalModalView()
        }
//        .sheet(isPresented: $alerter.showAlert) {
//            VStack {
//                Text("Custom Modal")
//                    .font(.headline)
//                Button("Close") {
//                    alerter.showAlert = false
//                }
//                .padding()
//            }
//        }
        
    }
}

struct Example4SecondView: View {
    var body: some View {
        ZStack {
            VStack {
                NavigationLink("Go to Third", destination: Example4ThirdView())
            }
        }
    }
}

struct Example4ThirdView: View {
    @Environment(\.alerterKey) var theAlerter
    var body: some View {
        VStack {
            Text("Third View")
            
            Button("Show Modal") {
                theAlerter.showAlert.toggle()
            }
        }
    }
}


#Preview {
    Example4View()
}

//
//  Example3View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 07/02/25.
//

import SwiftUI

struct Example3View: View {
    @State private var showAlert = false
    @State private var showModal = false
    @State private var contextMenuAction: String = "No action selected"

    var body: some View {
        VStack(spacing: 20) {
            // Button to show Alert
            Button("Show Alert") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Important Message"),
                    message: Text("This is an alert!"),
                    dismissButton: .default(Text("OK"))
                )
            }

            // Button to show Modal
            Button("Show Modal") {
                showModal = true
            }
            .sheet(isPresented: $showModal) {
                ModalView(isPresented: $showModal)
            }

            // Text with Context Menu
            Text("Long press me for options\nSelected: \(contextMenuAction)")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .contextMenu {
                    Button(action: {
                        contextMenuAction = "Copy selected"
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                    }

                    Button(action: {
                        contextMenuAction = "Share selected"
                    }) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }

                    Button(action: {
                        contextMenuAction = "Delete selected"
                    }) {
                        Label("Delete", systemImage: "trash")
                            .foregroundColor(.red)
                    }
                }
        }
        .padding()
    }
}

// Modal View
struct ModalView: View {
    @Binding var isPresented: Bool //alternate
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("This is a modal view!")
                .font(.title)
                .padding()

            Button("Dismiss") {
//                isPresented = false //alternate
                dismiss()
                
            }
            .padding()
        }
    }
}

struct Example3View_Previews: PreviewProvider {
    static var previews: some View {
        Example3View()
    }
}


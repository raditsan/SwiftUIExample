//
//  Example3View.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 07/02/25.
//

import SwiftUI

struct Example3View: View {
    @State private var showAlert = false
    @State private var showCustomModal = false
    @State private var contextMenuAction: String = "No action selected"

    var body: some View {
        ZStack {
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

                // Button to show Custom Modal
                Button("Show Custom Modal") {
                    showCustomModal = true
                }

                // Text with Context Menu
                Text("Long press me for options")
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

                // Display the selected context menu action
                Text("Last action: \(contextMenuAction)")
                    .padding()
            }
            .padding()

            // Custom Modal
            if showCustomModal {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showCustomModal = false
                    }

                CustomModalView(
                    title: "Confirmation",
                    message: "Are you sure you want to proceed?",
                    onYes: {
                        print("Yes button tapped")
                        showCustomModal = false
                    },
                    onNo: {
                        print("No button tapped")
                        showCustomModal = false
                    }
                )
                .transition(.opacity) // Add a transition animation
            }
        }
        .animation(.easeOut(duration: 0.2), value: showCustomModal) // Animate the modal appearance
    }
}

// Custom Modal View
struct CustomModalView: View {
    var title: String
    var message: String
    var onYes: () -> Void
    var onNo: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)

            HStack(spacing: 20) {
                Button(action: onNo) {
                    Text("No")
                        .font(.headline)
                        .padding()
                        .frame(width: 100)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: onYes) {
                    Text("Yes")
                        .font(.headline)
                        .padding()
                        .frame(width: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
//        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

// Modal View (for the sheet)
struct ModalView: View {
    var body: some View {
        VStack {
            Text("This is a modal view!")
                .font(.title)
                .padding()

            Button("Dismiss") {
                // Dismiss the modal
                // This is handled automatically by the `sheet` modifier
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

//
//  HomeDetailView.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//


import SwiftUI

struct HomeDetailView: View {
    var body: some View {
        VStack {
            Text("This is the Detail View")
                .font(.title)
                .padding()
            DetailComponent()
        }
    }
}

class DetailDataModel: ObservableObject {
    @Published var data: String = "\(Int(Date().timeIntervalSince1970))"
    var timer: Timer?
    
    func startTimer() {
        if timer != nil { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in
            print("Check", Date(), self as Any)
            self?.data = "\(Int(Date().timeIntervalSince1970))"
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct DetailComponent: View {
    @StateObject private var data = DetailDataModel()
    var body: some View {
        Text(data.data)
            .onAppear {
                data.startTimer()
            }
            .onDisappear {
                data.stopTimer()
            }
    }
}

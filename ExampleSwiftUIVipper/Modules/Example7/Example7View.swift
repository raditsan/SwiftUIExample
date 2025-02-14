//
//  Example7.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 13/02/25.
//

import SwiftUI


struct Example7View: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                requestNotificationPermission()
            }
            Button("Schedule Notification") {
                scheduleLocalNotification()
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "This is a local notification."
        content.sound = UNNotificationSound.default
        content.userInfo = ["notifId": 123]

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}

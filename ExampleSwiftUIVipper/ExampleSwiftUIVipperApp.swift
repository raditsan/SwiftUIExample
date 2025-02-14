//
//  ExampleSwiftUIVipperApp.swift
//  ExampleSwiftUIVipper
//
//  Created by raditsan on 05/02/25.
//

import SwiftUI

@main
struct ExampleSwiftUIVipperApp: App {
    let notificationDelegate = NotificationDelegate()
    
    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    
    @StateObject var alerter = Alerter()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            HomeRouter.createModule()
                .environment(\.alerterKey, alerter)
                if alerter.showAlert {
                    VStack {
                        Text("Custom Modal")
                            .font(.headline)
                        Button("Close") {
                            alerter.showAlert = false
                        }
                        .padding()
                    }
                }
//            Home2Router.createModule()
        }
    }
}

struct AlerterKey: EnvironmentKey {
    static let defaultValue = Alerter()
}

extension EnvironmentValues {
    var alerterKey: Alerter {
        get { return self[AlerterKey.self] }
        set { self[AlerterKey.self] = newValue }
    }
}

class Alerter: ObservableObject {
    @Published var showAlert = false
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("userInfo", userInfo)
        if response.actionIdentifier == "remindLater" {
            print("User asked to be reminded later.")
        }
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

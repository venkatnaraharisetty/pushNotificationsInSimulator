//
//  NotificationsDelegate.swift
//  pushNotificationsInSimulator
//
//  Created by Naraharisetty, Venkata (Chicago) on 4/2/20.
//  Copyright © 2020 Naraharisetty, Venkata (Chicago). All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension AppDelegate {

    func getRequestForNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            if granted {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("registered the notifications")
        // send the notificatiosn token to server to save
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert,.badge, .sound])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter,
                            didReceive response: UNNotificationResponse,
                            withCompletionHandler completionHandler: @escaping () -> Void) {
        showRespectiveScreen(response: response)
    }

    func showRespectiveScreen(response: UNNotificationResponse) {
        // show screen based on what is in response.notification.content
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? HomeViewController {
            self.window?.rootViewController = nextViewController
        }
    }

}

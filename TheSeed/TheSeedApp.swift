//
//  TheSeedApp.swift
//  TheSeed
//
//  Created by Iyanuoluwa Babatunde on 7/2/2025.
//

import SwiftUI
import Firebase
import UserNotifications
import AVFoundation

@main
struct TheSeedApp: App {
    @StateObject var audioPlayerManager = AudioPlayerManager()
    
    // Register AppDelegate for Firebase & Background Audio Support
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioPlayerManager)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        Messaging.messaging().delegate = self
        
        // Register for push notifications
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        
        // Subscribe to Firebase topic
        Messaging.messaging().subscribe(toTopic: "seed") { error in
            print("Subscribed to seed topic")
        }
        
        //  Set up background audio support
        configureAudioSession()

        return true
    }
    
    //  Enable Background Audio
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [.allowAirPlay, .duckOthers])
            try audioSession.setActive(true)
        } catch {
            print("⚠️ Error configuring AVAudioSession: \(error)")
        }
    }
    
    //  Ensure Audio Continues Playing When App Goes to Background
    func applicationDidEnterBackground(_ application: UIApplication) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("⚠️ Failed to keep AVAudioSession active in background: \(error)")
        }
    }
    
    //  Handle Incoming Push Notifications
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Push Notification Received - Message ID: \(messageID)")
        }
        
        print(userInfo)
        completionHandler(.newData)
    }
}

//  Firebase Messaging Delegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let deviceToken: [String: String] = ["token": fcmToken ?? ""]
        print("📲 Device token received: \(deviceToken)")
        
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: deviceToken
        )
    }
}

// Push Notification Handling
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Foreground Notification - Message ID: \(messageID)")
        }

        print(userInfo)
        completionHandler([.banner, .badge, .sound])
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("✅ Successfully registered for push notifications")
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("❌ Failed to register for push notifications: \(error.localizedDescription)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo[gcmMessageIDKey] {
            print("📩 Background Notification Opened - Message ID: \(messageID)")
        }

        print(userInfo)
        completionHandler()
    }
}

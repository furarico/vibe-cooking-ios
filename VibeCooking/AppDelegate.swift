//
//  AppDelegate.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import FirebaseCore
import Foundation
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

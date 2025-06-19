//
//  AppDelegate.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import FirebaseAppCheck
import FirebaseCore
import Foundation
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // AppCheck
        let providerFactory: AppCheckProviderFactory
#if targetEnvironment(simulator)
        providerFactory = AppCheckDebugProviderFactory()
#else
        providerFactory = MyAppCheckProviderFactory()
#endif
        AppCheck.setAppCheckProviderFactory(providerFactory)

        FirebaseApp.configure()
        return true
    }
}

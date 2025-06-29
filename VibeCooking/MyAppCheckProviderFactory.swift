//
//  MyAppCheckProviderFactory.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import FirebaseAppCheck
import FirebaseCore

final class MyAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        return AppAttestProvider(app: app)
    }
}

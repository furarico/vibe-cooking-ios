//
//  Environment.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

protocol EnvironmentProtocol: Actor {
    static var shared: Self { get }

    var appCheckRepository: AppCheckRepositoryProtocol { get }
    var recipeRepository: RecipeRepositoryProtocol { get }
}

final actor EnvironmentImpl: EnvironmentProtocol {
    static let shared: EnvironmentImpl = .init()

    let appCheckRepository: any AppCheckRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryImpl(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryImpl()
    ) {
        self.appCheckRepository = appCheckRepository
        self.recipeRepository = recipeRepository
    }
}

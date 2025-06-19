//
//  MockEnvironment.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/06/19.
//

import Foundation

final actor MockEnvironment: EnvironmentProtocol {
    static let shared: MockEnvironment = .init()

    let appCheckRepository: any AppCheckRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryMock(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryMock()
    ) {
        self.appCheckRepository = appCheckRepository
        self.recipeRepository = recipeRepository
    }
}

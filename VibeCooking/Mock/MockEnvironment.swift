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
    let speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryMock(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryMock(),
        speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol = SpeechRecognitionRepositoryMock()
    ) {
        self.appCheckRepository = appCheckRepository
        self.recipeRepository = recipeRepository
        self.speechRecognitionRepository = speechRecognitionRepository
    }
}

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
    var speechRecognitionRepository: SpeechRecognitionRepositoryProtocol { get }
}

final actor EnvironmentImpl: EnvironmentProtocol {
    static let shared: EnvironmentImpl = .init()

    let appCheckRepository: any AppCheckRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol
    let speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryImpl(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryImpl(),
        speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol = SpeechRecognitionRepositoryImpl()
    ) {
        self.appCheckRepository = appCheckRepository
        self.recipeRepository = recipeRepository
        self.speechRecognitionRepository = speechRecognitionRepository
    }
}

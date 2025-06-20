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
    let audioRepository: any AudioRepositoryProtocol
    let localRepository: any LocalRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol
    let speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol

    init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryMock(),
        audioRepository: any AudioRepositoryProtocol = AudioRepositoryMock(),
        localRepository: any LocalRepositoryProtocol = LocalRepositoryMock(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryMock(),
        speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol = SpeechRecognitionRepositoryMock()
    ) {
        self.appCheckRepository = appCheckRepository
        self.audioRepository = audioRepository
        self.localRepository = localRepository
        self.recipeRepository = recipeRepository
        self.speechRecognitionRepository = speechRecognitionRepository
    }
}

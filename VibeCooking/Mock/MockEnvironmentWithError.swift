//
//  MockEnvironmentWithError.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/07/04.
//

final actor MockEnvironmentWithError: EnvironmentProtocol {
    static let shared = MockEnvironmentWithError()

    let appCheckRepository: any AppCheckRepositoryProtocol
    let audioRepository: any AudioRepositoryProtocol
    let localRepository: any LocalRepositoryProtocol
    let recipeRepository: any RecipeRepositoryProtocol
    let speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol

    private init(
        appCheckRepository: any AppCheckRepositoryProtocol = AppCheckRepositoryMock(),
        audioRepository: any AudioRepositoryProtocol = AudioRepositoryMock(),
        localRepository: any LocalRepositoryProtocol = LocalRepositoryMock(),
        recipeRepository: any RecipeRepositoryProtocol = RecipeRepositoryMockWithError(),
        speechRecognitionRepository: any SpeechRecognitionRepositoryProtocol = SpeechRecognitionRepositoryMock()
    ) {
        self.appCheckRepository = appCheckRepository
        self.audioRepository = audioRepository
        self.localRepository = localRepository
        self.recipeRepository = recipeRepository
        self.speechRecognitionRepository = speechRecognitionRepository
    }
}

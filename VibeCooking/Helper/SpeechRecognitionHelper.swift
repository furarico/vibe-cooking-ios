//
//  SpeechRecognitionHelper.swift
//  VibeCooking
//
//  Created by Kanta Oikawa on 2025/11/26.
//

import Speech

final actor SpeechRecognitionHelper {

    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    private let (transcriptionStream, transcriptionContinuation): (AsyncStream<TranscriptionResult>, AsyncStream<TranscriptionResult>.Continuation)

    init() {
        recognizer = SFSpeechRecognizer(locale: .current)
        (transcriptionStream, transcriptionContinuation) = AsyncStream<TranscriptionResult>.makeStream()
    }

    func startTranscribing() async throws -> AsyncStream<TranscriptionResult> {
        guard let recognizer else {
            throw SpeechRecognitionRepositoryError.nilRecognizer
        }

        guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
            throw SpeechRecognitionRepositoryError.notAuthorizedToRecognize
        }

        guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
            throw SpeechRecognitionRepositoryError.notPermittedToRecord
        }

        try transcribe(recognizer: recognizer)

        return transcriptionStream
    }

    func stopTranscribing() {
        reset()
    }

    func clearTranscriptions() throws {
        reset()
        guard let recognizer else {
            return
        }
        try transcribe(recognizer: recognizer)
    }

    private func transcribe(recognizer: SFSpeechRecognizer) throws {
        guard recognizer.isAvailable else {
            throw SpeechRecognitionRepositoryError.recognizerIsUnavailable
        }

        do {
            let (audioEngine, request) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request, resultHandler: recognitionHandler)
        } catch {
            reset()
            throw error
        }
    }

    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }

    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()

        return (audioEngine, request)
    }

    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        if let result {
            transcriptionContinuation.yield(.success(result.bestTranscription.formattedString))
        }
        if let error {
            transcriptionContinuation.yield(.failure(error))
        }
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}

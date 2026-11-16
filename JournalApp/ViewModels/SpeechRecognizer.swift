import Foundation
import Speech
import AVFoundation
import Observation

@MainActor
@Observable
final class SpeechRecognizer {

    var isRecording = false
    var recognizedText = ""

    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    func startRecording() async {
        let speechAuthorized = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }

        guard speechAuthorized else { return }

        let microphoneAuthorized = await AVAudioApplication.requestRecordPermission()
        guard microphoneAuthorized else { return }

        guard let speechRecognizer, speechRecognizer.isAvailable else { return }

        do {
            stopRecording()
            recognizedText = ""

           #if os(iOS)
           let session = AVAudioSession.sharedInstance()
           try session.setCategory(.record, mode: .measurement, options: .duckOthers)
           try session.setActive(true, options: .notifyOthersOnDeactivation)
           #endif

            let request = SFSpeechAudioBufferRecognitionRequest()
            request.shouldReportPartialResults = true
            recognitionRequest = request

            let inputNode = audioEngine.inputNode
            let format = inputNode.outputFormat(forBus: 0)
            
            #if os(iOS)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
                request.append(buffer)
            }
            #endif
            
            recognitionTask = speechRecognizer.recognitionTask(with: request) { [weak self] result, error in
                Task { @MainActor in
                    if let result {
                        self?.recognizedText = result.bestTranscription.formattedString

                        if result.isFinal {
                            self?.stopRecording()
                        }
                    }

                    if error != nil {
                        self?.stopRecording()
                    }
                }
            }

            audioEngine.prepare()
            try audioEngine.start()
            isRecording = true

        } catch {
            stopRecording()
            print("Speech recognition error: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        if audioEngine.isRunning {
            audioEngine.stop()
        }

        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()

        recognitionRequest = nil
        recognitionTask = nil
        isRecording = false

            #if os(iOS)
            try? AVAudioSession.sharedInstance().setActive(
            false,
            options: .notifyOthersOnDeactivation
            )
            #endif
    }
}

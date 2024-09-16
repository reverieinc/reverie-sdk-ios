# Speech to Text | Streaming
The Speech-to-Text accurately converts speech into text using an API powered by Reverie's AI technology. The solution will transcribe the speech in real-time of various Indian languages and audio formats.
> **Note: On the basis of the selected [domain](#supporting-domain) the result will vary**
## Key Features
The Speech-to-Text solution offers robust features that help in delivering better user experience in interacting with the products through voice commands:

- Real-time Transcription:
The pre-recorded audio files are transcribed accurately into text format in real-time. It will decode speech with high accuracy and confidence, even from the lower-quality audio input.

- Personalize Speech Model:
Tailor speech recognition to transcribe domain-specific terms and boost your transcription accuracy of specific words or phrases.

- Noise Resistance:
The solution will decode moderate noisy audio data recorded in various environments without requiring additional noise cancellation.

- Content Filtering:
Obscenity filter will detect inappropriate or unprofessional content in your audio data and filter out profane words in text output.

###  Supporting Languages

The solution will understand regional accents, bi-lingual nature of Indians, and is dialect-agnostic. it will transcribe the audio from widely spoken Indian languages:
.


| Language  | Code | Language | Code |
|-----------|------|----------|------|
| Hindi     | hi   | Bengali  | bn   |
| Gujarati  | gu   | Kannada  | kn   |
| Tamil     | ta   | Punjabi  | pa   |
| Telugu    | te   | English  | en   |
| Marathi   | mr   | Assamese | as   |
| Malayalam | ml   | Odia     | or   |

### Supporting Domain
The universe in which the Streaming STT API is used for transcribing the speech. 

| Domain Name | SDK Constants       |
|-------------|---------------------|
| generic     | `SttDomain.GENERIC` |
| bfsi        | `SttDomain.BFSI`    |
| ecomm       | `SttDomain.ECOMM`   |


## SDK usage example:

                                                                  
### Swift based example implementation of the SDK:
 1. Prepare the constructor:

     ```sh
    //Preparing the constructor with valid API key and APP-ID
        let SttStreaming=StreamingSTT( apikey: String, appId: String, lang:String,domain: String,logging:String)
    ```
    ```sh
    //Preparing the Constructor with  API-key , APP-ID , language,domain and logging
      let SttStreaming=StreamingSTT(apikey: String, appId: String,logging: Logging.TRUE)
    ```
 2. Add Listeners to ViewControllerClass
    
    ```sh
        struct StreamingUI: View , StreamingDelegate  {
    
        func onConnectionSucess(isTrue: Bool) {
        
        }
    
        func onRecordingData(data: Data) {
        
        }
    
        func onResult(data: StreamingResultData) {
            output = data.display_text
        }
    
        func onError(data: String) {
            isRecording = false
            recordingText="Click Here to Speak"
        }
    
        func onRecordingStart(isTrue: Bool) {
            isRecording = true
            recordingText="listening..."
        }
    
    func onRecordingEnd(isTrue: Bool) {
        isRecording = false
        recordingText="Click Here to Speak"
    }
    
   
    ```

3. Start Voice Input
    ```sh
    SttStreaming.startStreaming(domain: SpeechToTextDomain.GENERIC, lang: sourceLanguage, logging: Logging.TRUE)    ```
   
4. Stop the Voice Streaming for final Result
    ```sh
     SttStreaming.finishInput()
    ```
5. Terminate Voice Streaming without final
    ```sh
     SttStreaming.cancel()
     
    ```


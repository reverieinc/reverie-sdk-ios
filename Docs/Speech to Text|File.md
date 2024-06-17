# Speech to Text | FileSTT
The Speech-to-Text accurately converts speech into text using an API powered by Reverie's AI technology. The solution will transcribe the speech in real-time of various Indian languages and audio formats.
The solution is a fully managed and continually trained solution, which leverages machine learning to combine knowledge of grammar, language structure, and the composition of audio and voice signals to accurately transcribe the speech.
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
| bfsi        | `SttDomain.BSFI`    |

To understand the `Domains` better please refer to [Supporting Domains](https://docs.reverieinc.com/speech-to-text-file-api#supporting-domains)



## SDK usage example:

                                                                  
### Swift based example implementation of the SDK:

 1. Prepare the constructor:

     ```sh
    //Preparing the constructor with valid API key and APP-ID
       let fileStt = FileSTT(appId: "",apiKey:"" )
    ```
  
 2. Add Listeners to ViewControllerClass/SwiftUI Struct 
    
    ```sh
    struct FileSttUI: View,FileSTTDelegates {
    
    func onResult(data: FileSTTResponseData) {
        print("From File stt")
        output=data.display_text
        inProcess=false
    }
    
    func onError(error: String) {
        print(error)
        output=error
        inProcess=false
    }
       
    ```

 3. Set the Delegate Listener
    ```sh
        fileStt.setFileSttDelegates(delegate: self)   
    ```
    
 4. Upload the File via giving the File URL to the function
    ```sh
       fileStt.upload(fileURL: Fileurl, domain: "generic", language: sourceLanguage)   
    ```   

 5. To Set the Format(Optional)
    ```sh
    filestt.setFormat(format: "mp3")
    ```

 6. To Set the Logging(Optional)
    ```sh
    filestt.setLogging(logging: "TRUE")
    ```

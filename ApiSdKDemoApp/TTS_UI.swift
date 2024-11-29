
/*
 * All Rights Reserved. Copyright 2024. Reverie Language Technologies Limited.(https://reverieinc.com/)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */ 
//

import SwiftUI
import AVFoundation
import ReverieLanguageAPISDK
//import RevVoiceSearchSDK
struct TTS_UI: View,TextToSpeechDelegate {
    @Environment(\.presentationMode) var presentationMode
    func onResult(data: Data) {
        playAudio(data: data)
    }
    
    func onError(data: String,errorTag:Int) {
    
    }
    @State private var SelectedSpeaker = Speaker.ENGLISH_FEMALE
     
    
    @State private var sourceLanguage = 0
    @State private var targetLanguage = 1
    @State private var textInput=""
    @State private var output=""
    private var tts=TextToSpeech(apikey:Constants.apiKey, appId: Constants.appId
    )
    @State private var responseData: String = ""
    @State private var audioPlayer:AVAudioPlayer!
    var body: some View {
     
        
        NavigationView{
            
            VStack(spacing:0)
            {
                
                VStack(spacing:0){
                    ZStack(alignment:.topLeading) {
                        // Brown color box
                        Rectangle()
                            .fill(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: 80)
                        
                        
                        // Image in the top-left corner
                        
                        VStack {
                            Spacer()
                            
                            // Your view goes here
                            HStack{
                                Image("Reverie logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 140, height: 40).padding(EdgeInsets(top: 10, leading: 20, bottom: 10,trailing: 0))
                                
                                
                                
                                Spacer()
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        
                        
                        
                    }.frame(maxHeight: 80)
                    
                    
                    
                    
                    ZStack(alignment:.topLeading) {
                        // Brown color box
                        Image("backwelcome")
                            .resizable()
                        
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        
                        
                        VStack {
                            Spacer()
                            
                            // Your view goes here
                            HStack{
                                NavigationLink(destination:MainView().navigationBarBackButtonHidden(true))
                                {
                                    Image("backArrow")
                                        .resizable()
                                        .frame(width: 20,height: 20).padding(EdgeInsets(top: 5, leading: 10, bottom: 0,trailing: 0)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).onTapGesture {
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                }
                                
                                Spacer()
                                Text("TTS".localized).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 10, bottom: 0,trailing: 10)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                
                                
                                Spacer()
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        
                        
                        
                    }.frame(maxHeight: 80)
                    
                }
                
                HStack{
                    
                    Picker("Left Picker", selection: $SelectedSpeaker) {
                                    Text("English Female").tag(Speaker.ENGLISH_FEMALE)
                                        Text("Hindi Female").tag(Speaker.HINDI_FEMALE)
                                        Text("Hindi Male").tag(Speaker.HINDI_MALE)
                                        Text("Odia Male").tag(Speaker.ODIA_MALE)
                                        Text("Odia Female").tag(Speaker.ODIA_FEMALE)
                                        Text("Bengali Male").tag(Speaker.BENGALI_MALE)
                                        Text("Bengali Female").tag(Speaker.BENGALI_FEMALE)
                                        Text("Kannada Male").tag(Speaker.KANNADA_MALE)
                                        Text("Kannada Female").tag(Speaker.KANNADA_FEMALE)
                                        Text("Malayalam Male").tag(Speaker.MALAYALAM_MALE)
                                        Text("Malayalam Female").tag(Speaker.MALAYALAM_FEMALE)
                                        Text("Tamil Male").tag(Speaker.TAMIL_MALE)
                                        Text("Tamil Female").tag(Speaker.TAMIL_FEMALE)
                                        Text("Telugu Male").tag(Speaker.TELUGU_MALE)
                                        Text("Telugu Female").tag(Speaker.TELUGU_FEMALE)
                                        Text("Gujarati Male").tag(Speaker.GUJARATI_MALE)
                                        Text("Gujarati Female").tag(Speaker.GUJARATI_FEMALE)
                                        Text("Assamese Male").tag(Speaker.ASSAMESE_MALE)
                                        Text("Assamese Female").tag(Speaker.ASSAMESE_FEMALE)
                                        Text("Marathi Male").tag(Speaker.MARATHI_MALE)
                                        Text("Marathi Female").tag(Speaker.MARATHI_FEMALE)
                                        Text("Punjabi Male").tag(Speaker.PUNJABI_MALE)
                                        Text("Punjabi Female").tag(Speaker.PUNJABI_FEMALE)
                    }
                    
                    .padding()
                    
                    Spacer()
                    
                    
                    Spacer()
                    
                   
                    
                    
                    
                }
                
                
                    VStack(content: {
                        
                        
                        TextField("Source Content", text: $textInput).frame(width: .infinity,height: 200).multilineTextAlignment(.center).padding(EdgeInsets(top: 50, leading: 10, bottom: 50,trailing: 10))
                        Spacer()
                        
                       
                    }
                           
                           
                    )
                    
                    
                    
                
                
                Spacer()
                Text(NSLocalizedString("Click Here to Speak", comment: "Click Here To Speak")).onTapGesture {
                    tts.callTTS(text: textInput, speaker: SelectedSpeaker)
                    print("Click Here to Speak".localized)
                    
                }
                
            } .ignoresSafeArea(.keyboard).hiddenNavigationBarStyle().onAppear{
                tts.setDelegate(ttsDelegate: self)
                
            }
            
            
            
            
            
        }.hiddenNavigationBarStyle().onAppear{
            
            presentationMode.wrappedValue.dismiss()
            
        }}
    
        

    func playAudio(data: Data) {
            do {
                // Create an AVAudioPlayer with the audio data
                print(data)
                audioPlayer = try AVAudioPlayer(data: data)

                // Start playing the audio
                audioPlayer.play()
                print(audioPlayer.isPlaying)
            } catch {
                print("Error creating AVAudioPlayer: \(error.localizedDescription)")
            }
        }
        
    
    }


#Preview {
    TTS_UI()
    
}

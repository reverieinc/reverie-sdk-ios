
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

import ReverieLanguageAPISDK
struct StreamingUI: View , StreamingSTTDelegates {
    @Environment(\.presentationMode) var presentationMode
    func onConnectionSucess(isTrue: Bool) {
        
    }
    
    func onRecordingData(data: Data) {
        
    }
    
    func onResult(data: StreamingResultData) {
        output = data.display_text
    }
    
    func onError(data: String) {
        isRecording = false
        recordingText="Click Here to Speak".localized
    }
    
    func onRecordingStart(isTrue: Bool) {
        isRecording = true
        recordingText="listening...".localized
    }
    
    func onRecordingEnd(isTrue: Bool) {
        isRecording = false
        recordingText="Click Here to Speak".localized
    }
    
   

    var voiceStt = StreamingSTT(apikey:Constants.apiKey, appId: Constants.appId, logging: "TRUE")
 
    
   @State private var isRecording=false
    @State private var output=""
    @State private var sourceLanguage = "en"
   
    @State private var textInput=""
   @State private var abc1=""
    @State private var recordingText="Click Here to Speak".localized
    @State private var responseData: String = ""
 
    public var body: some View {
        
        NavigationView
        {
            
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
                                            voiceStt.cancel()
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                }
                                
                                Spacer()
                                Text("Streaming STT".localized).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 1, bottom: 0,trailing: 10)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                
                                
                                Spacer()
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        
                        
                        
                    }.frame(maxHeight: 80)
                    
                }
                
                HStack{
                    
                    Picker("Left Picker", selection: $sourceLanguage) {
                        Text("English").tag("en")
                        Text("Hindi").tag(Languages.HINDI)
                        Text("Bengali").tag(Languages.BENGALI)
                        Text("Kannada").tag(Languages.KANNADA)
                        Text("Malayalam").tag(Languages.MALAYALAM)
                        Text("Gujarati").tag(Languages.GUJARATI)
                        Text("Assamese").tag(Languages.ASSAMESE)
                        Text("Marathi").tag(Languages.MARATHI)
                        Text("Odia").tag(Languages.ODIA)
                        Text("Tamil").tag(Languages.TAMIL)
                        Text("Telgu").tag(Languages.TELUGU)
                        Text("Punjabi").tag(Languages.PUNJABI)
                        
                        
                    }
                    
                    .padding()
                    
                    
                    
                    
                    Spacer()
                    
                    
                    Spacer()
                    
                  
                    
                    
                    
                }
                
                
                    VStack(content: {
                        
                        Spacer()
                        Text(self.output).frame(width: .infinity,height: 200).multilineTextAlignment(.center).padding(EdgeInsets(top: 0, leading: 10, bottom: 0,trailing: 10))
                        Spacer()
                        
                       
                    }
                           
                           
                    ).frame(width: .infinity,height: .infinity)
                    
                    
                    
                
                
                Spacer()
                Text(recordingText).onTapGesture {
                
                if(!isRecording)
                    {
                   
                    voiceStt.startRecognition( voiceInputDelegates: self, isUIRequired: false, domain:SpeechToTextDomain.GENERIC, lang: sourceLanguage)
                    output = ""
                }
                    else{
                        voiceStt.finishInput()
                        
                        
                    }
             
                    
                    print(Thread.current)
                }
                
            }.hiddenNavigationBarStyle()
            
            
            
            
        }.hiddenNavigationBarStyle().onAppear {
          
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
            AppDelegate.orientationLock = .portrait
           
        }.onDisappear {
            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
        }
        
        
    }
}

extension View {
   
}
#Preview {
    StreamingUI()
}
struct PortraitViewController<Content: View>: UIViewControllerRepresentable {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.addSubview(UIHostingController(rootView: content).view)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Lock the orientation to portrait
        let orientation = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(orientation, forKey: "orientation")
    }
}

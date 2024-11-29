
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
struct FileSttUI: View,FileSTTDelegates {
    
    func onResult(data: FileSTTResponseData) {
        print("From File stt")
        output=data.display_text
        inProcess=false
    }
    
    func onError(error: String,errorTag:Int) {
        print(error)
        output=error
        inProcess=false
    }
    @Environment(\.presentationMode) var presentationMode
    var s =  FileSTT(appId:Constants.appId, apiKey:Constants.apiKey)
    @State private var sourceLanguage = Languages.ENGLISH
    @State private var isLoading=false
    @State private var inProcess=false
    @State private var textInput=""
    @State private var output=""
    @State private var isRotating=0.0
    
    @State var isShowing=false
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
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
                                        Text("File Stt".localized).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 1, bottom: 0,trailing: 10)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        
                                        
                                        Spacer()
                                        
                                    }
                                    
                                    
                                    Spacer()
                                }
                                
                                
                                
                                
                            }.frame(maxHeight: 80)
                            
                        }
                        
                        HStack{
                            
                            Picker("Left Picker", selection: $sourceLanguage) {
                                Text("English").tag(Languages.ENGLISH)
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
                            
                            ZStack{
                                
                                
                                Text(output).frame(width: .infinity,height: 200).multilineTextAlignment(.center).padding(EdgeInsets(top: 50, leading: 10, bottom: 50,trailing: 10))
                                
                            }
                        }
                               
                               
                        )
                        
                        
                        
                        
                        
                        Spacer()
                        ZStack{
                            
                            Text("Click Here to Upload".localized.localized).onTapGesture {
                                if(!inProcess)
                                {   isShowing.toggle()}
                                
                                
                            }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
                                
                                switch result {
                                case .success(let Fileurl):
                                    
                                    print(Fileurl.relativeString)
                                    s.setFileSttDelegates(delegate: self)
                                    s.upload(fileURL: Fileurl, domain: "generic", language: sourceLanguage)
                                    self.inProcess=true
                                    isRotating=0.0
                                    output=""
                                case .failure(let error):
                                    print(error)
                                }
                                
                            }
                            
                            
                        } .ignoresSafeArea(.keyboard).hiddenNavigationBarStyle().onAppear{
                            // tts.setDelegate(ttsDelegate: self)
                            
                        }
                        
                        
                        
                        
                        
                    }.hiddenNavigationBarStyle().onAppear {
                        
                        //voiceStt.setDelegates(voiceSearchDelegate: self)
                        //presentationMode.wrappedValue.dismiss()
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                        AppDelegate.orientationLock = .portrait
                        
                    }.onDisappear {
                        AppDelegate.orientationLock = .all // Unlocking the rotation when
                    }
                    
                }
                if(inProcess)
                {  VStack{
                    
                    CircularProgress().rotationEffect(.degrees(isRotating)).onAppear{
                        withAnimation(.linear(duration: 1)
                            .repeatForever(autoreverses: false)) {
                                isRotating = 360.0
                            }                }}
                }
            }
        }.onAppear{
            
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
#Preview {
    FileSttUI()
}
struct RotatingCircle: View {
    @State private var isAnimating = false
    @State private var rotation: Double = 0
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.blue, lineWidth: 10)
            .frame(width: 100, height: 100)
            .fixedSize()
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                withAnimation(Animation.linear(duration: 0.2).repeatForever(autoreverses: false)) {
                    self.rotation = 360
                }
            }
    }
}
struct CircularProgress: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            
            //                .stroke(lineWidth: 20.0)
            //                .opacity(0.3)
            //                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: 0.7)
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(.degrees(-180))
                .animation(.easeInOut(duration: 1.0))
        }
        .frame(width: 80, height: 80)
        .onAppear {
            
        }
    }
}

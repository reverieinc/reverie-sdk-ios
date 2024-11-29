
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

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
}


struct MainView: View{
    @State private var showRelaunchAlert = false
    @State var lang = "en"
    @State private var sourceLanguage = Locale.current.languageCode!
    
        @State private var textInput=""
        @State private var output=""
        @State private var responseData: String = ""

    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            
            VStack (spacing: 0){
                
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
                            Image("Settings")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30).padding(EdgeInsets(top: 20, leading: 50, bottom: 10,trailing: 0)).onTapGesture {
                                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                               UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                                           }
                                }
                           
                            
                            
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
                            Spacer()
                            Text(NSLocalizedString("Welcome following demos have been added been designed for you.Please try and share the feedback", comment: "" )).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 10, bottom: 0,trailing: 10))
                            
                            
                            Spacer()
                            
                        }
                        
                        
                        Spacer()
                    }
                    
                    
                    
                    
                }.frame(maxHeight: 100)
                
                ScrollView(.vertical){
                    VStack(spacing: 10) {
                        HStack {
                            // Item 1
                            NavigationLink(destination:Transliteration_UI().navigationBarBackButtonHidden(true)) {
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xEAF4F8))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    
                                    VStack{
                                        Text(NSLocalizedString("Transliteration", comment: "")).foregroundColor(.black)
                                        
                                    }
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                            
                            NavigationLink(destination: Translation_UI().navigationBarBackButtonHidden(true)) {
                                // Item 2
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xF2FCEF))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    
                                    VStack{
                                        Text("Translation".localized).foregroundColor(.black)
                                        
                                    }
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                        
                        }
                        
                        
                        HStack {
                            NavigationLink(destination: TTS_UI().navigationBarBackButtonHidden(true)) {
                                // Item 2
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xF2FCEF))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    VStack{
                                        Text("TTS".localized).foregroundColor(.black)
                                        
                                    }
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                            
                            NavigationLink(destination: StreamingUI().navigationBarBackButtonHidden(true)) {
                                // Item 2
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xEAF4F8))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    VStack{
                                        Text("Streaming STT".localized).foregroundColor(.black)
                                        
                                    }
                                    
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                            // Item 1
                           
                            // Item 2
                            
                            
                            
                           
                        }
                        
                        
                        HStack {
                            NavigationLink(destination: FileSttUI().navigationBarBackButtonHidden(true)) {
                                // Item 2
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xEAF4F8))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    VStack{
                                        Text("File Stt".localized).foregroundColor(.black)
                                        
                                    }
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                            
                            NavigationLink(destination: BatchSttUi().navigationBarBackButtonHidden(true)) {
                                // Item 2
                                ZStack{      Rectangle()
                                        .fill(Color(hex:0xF2FCEF))
                                        .frame(maxWidth: .infinity, maxHeight: 200)
                                    VStack{ 
                                        Text("Batch STT".localized).foregroundColor(.black)
                                        
                                    }
                                    
                                    
                                }.frame(maxWidth:.infinity,minHeight: 200).cornerRadius(10)
                            }
                            // Item 1
                            
                            // Item 2
                            
                            
                            
                        }
                        
                        
                    }.padding(EdgeInsets(top:10, leading:10, bottom:10, trailing: 10))
                
            }
            
            
                
                
            }.hiddenNavigationBarStyle().onAppear {
                // Your setup code here

                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") //
                AppDelegate.orientationLock = .portrait
              
                
            }.onDisappear {
                AppDelegate.orientationLock = .all // Unlocking the rotation when
            } .alert(isPresented: $showRelaunchAlert) {
                Alert(
                    title: Text("Relaunch Required"),
                    message: Text("Please relaunch the app to apply changes."),
                    primaryButton: .default(Text("Relaunch"), action: {
                        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    exit(0)
                                }
                    }),
                    secondaryButton: .cancel()
                )
            }
            
            Spacer()
        }.navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
struct CircularProgressBarView: View {
    @State private var rotation: Double = 0

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: rotation))
            .onAppear {
                withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                    self.rotation = 360
                }
            }
    }
}
extension String {
    var localized: String {
                NSLocalizedString(self, comment: "")
    }
}
#Preview {
    MainView()
}
class ReloadViewHelper: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}

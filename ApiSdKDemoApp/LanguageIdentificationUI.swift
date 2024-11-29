
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
struct LanguageIdentificationUI: View,LanguageIdentificationDelegate {
    func onResult(data: ReverieLanguageAPISDK.LanguageIndetificationData) {
        output = "\(data)"
        
    }
    
    func onError(error: String, errorTag: Int) {
        
    }
    
    @State private var sourceLanguage = Languages.ENGLISH
    @State private var targetLanguage = Languages.HINDI
    @State private var textInput=""
    @State private var output=""
    @State private var responseData: String = ""
    var languageDetect = LanguageIdentification(appId: Constants.appId, apiKey:Constants.apiKey )
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack{
                
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
                                Text("Language Indentify".localized).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 1, bottom: 0,trailing: 10)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                
                                
                                Spacer()
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        
                        
                        
                    }.frame(maxHeight: 80)
                    
                }
                
               
                ScrollView(.vertical){
                    VStack(content: {
                        
                        TextField("Source Content".localized, text: $textInput).frame(width: .infinity,height: 200).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 10, bottom: 0,trailing: 10))
                        HStack{
                            Rectangle()
                                .fill(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                            Image("arrow")
                                .resizable()
                                .frame(width: 30, height: 30).rotationEffect(.degrees(90))
                                .onTapGesture {
                                    print("onclick button")
                                  
                                    languageDetect.identifyLanguage(text: textInput )
                                  //  fetchDataFromAPI()
                                }
                            Rectangle()
                                .fill(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: 1)
                        }
                        
                        HStack( content: {
                            Text("Output".localized)
                            Spacer()
                        }).padding(EdgeInsets(top: 5, leading: 10, bottom: 0,trailing: 10))
                        
                        Text(output).frame(width: .infinity).multilineTextAlignment(.center).padding(EdgeInsets(top: 80, leading: 10, bottom: 0,trailing: 10))
                    }
                           
                           
                    )
                    
                    
                    
                }
                
                Spacer()
            }.hiddenNavigationBarStyle()
        }.onAppear{
            
            languageDetect.setDelegate(languageDelegate: self)
            
        }.hiddenNavigationBarStyle().onAppear {
   
            
        }.onDisappear {
            //AppDelegate.orientationLock = .all // Unlocking the rotation when
        }
    }
    
}

#Preview {
    LanguageIdentificationUI()
}


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
struct BatchSttUi: View,BatchSttDelegates {
    @Environment(\.presentationMode) var presentationMode
    func onResultTranscript(data: ReverieLanguageAPISDK.BatchTranscriptResult) {
        inProcess=false
        print("sucess")
        print(data.message)
        output=data.result.transcript ?? ""
    }
    
    func onResultUpload(data: ReverieLanguageAPISDK.BatchUploadData) {
        let job_id = data.job_id
        //s.checkStatus(jobId: job_id)
        print(data.code)
        
     checkStatusTimer(job_id: job_id)
//        DispatchQueue.main.async {
//            print("Entering")
//            checkStatusTimer()
//        }
    
    }
    
    func onError(error: String,errorTag:Int) {
        inProcess=false
    }
    
    func onResultStatus(data: ReverieLanguageAPISDK.BatchStatusData) {
        print("From Parent Struct \(data.code)")
        if(data.code=="000")
        {  // timer.invalidate()
            batchStt.getTranscript(jobId: data.job_id)
            timer?.invalidate()
            
        }
        if(data.code=="005")
        {
            timer?.invalidate()
            print(data.message)
            output=data.message
            inProcess=false
            
        }
      
        
    }
    @State var timer :Timer?
    func checkStatusTimer(job_id:String)
    {
      timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            //print("Checking")
            batchStt.checkStatus(jobId: job_id )
            //s.checkStatus(jobId: )
           }
          
        
        
    }
    @State  var batchStt =  BatchSTT(appId: Constants.appId,apiKey:Constants.apiKey)
    @State var output = ""
    @State var isShowing=false
    @State private var sourceLanguage = Languages.ENGLISH
    @State private var inProcess=false
    @State private var isRotating=0.0
    @State private var textInput=""
    //@State  var timer: Timer?
    
    var body: some View {
                
        NavigationView{
            ZStack{
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
                                    Text("Batch STT".localized).multilineTextAlignment(.center).padding(EdgeInsets(top: 5, leading: 1, bottom: 0,trailing: 10)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    
                                    
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
                        
                        
                        Text(output).frame(width: .infinity,height: 200).multilineTextAlignment(.center).padding(EdgeInsets(top: 50, leading: 10, bottom: 50,trailing: 10))
                        Spacer()
                        
                        
                    }
                           
                           
                    )
                    
                    
                    
                    
                    
                    Spacer()
                    Text("Click Here to Upload".localized).onTapGesture {
                        if(!inProcess)
                        {isShowing.toggle()}
                        
                        
                    }.fileImporter(isPresented: $isShowing, allowedContentTypes: [.item]) { result in
                        
                        switch result {
                        case .success(let Fileurl):
                        
                            print(Fileurl.relativeString)
                            batchStt.setBatchDelegates(batchSttDelegates: self)
                            isRotating=0.0
                            batchStt.upload(fileURL: Fileurl, domain: "generic", language: sourceLanguage)
                            output=""
                            self.inProcess=true
//                            output="inProcess"
                        case .failure(let error):
                            print(error)
                        }
                        
                    } .ignoresSafeArea(.keyboard).hiddenNavigationBarStyle().onAppear{
                        // tts.setDelegate(ttsDelegate: self)
                        
                    }
                    
                    
                    
                    
                    
                }.hiddenNavigationBarStyle().onAppear {
                    //voiceStt.setDelegates(voiceSearchDelegate: self)
                  //  presentationMode.wrappedValue.dismiss()
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
                    AppDelegate.orientationLock = .portrait
                   
                }.onDisappear {
                    AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
                }
                if(inProcess)
                {
                    VStack{
                    
                    CircularProgress().rotationEffect(.degrees(isRotating)).onAppear{
                        withAnimation(.linear(duration: 1)
                            .repeatForever(autoreverses: false)) {
                                isRotating = 360.0
                            }                }}
                }
            }
         
            
        }.navigationBarTitle("")
            .navigationBarHidden(true)
        
        
    }
}

#Preview {
    BatchSttUi()
}

//
//  MoreViews.swift
//  TheSeed
//
//  Created by Lawrence Adeyemi on 15/10/2022.
//

import SwiftUI
import MessageUI
import FirebaseAnalytics

struct MoreViews: View {
    
    @Environment(\.openURL) var openURL
    private var email = SupportEmail(messageHeader: "Please put in your message below this line ")
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                    }
                    //contact us
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("Contact us")
                            .font(.title2)
                        
                        VStack(alignment: .leading, spacing: 5.0) {
                            Text("Jerusalem Church of The Lord,")
                            Text("1 Jerusalem Avenue, Kilometer 4, Ikere Road,")
                            Text("Ado-Ekiti, Ekiti State, Nigeria")
                        }
                        .foregroundColor(.gray)
                        
                        
                        HStack(alignment: .bottom, spacing: 20) {
                            Button {
                                call()
                            } label: {
                                Text("Call")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .frame(width: 80, height: 32)
                                    .foregroundColor(.blue)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.15))
                            }
                            
                            Button {
                                email.send(openURL: openURL, toAddress: "info@ileewe.org", subject: "Contact us")
                            } label: {
                                Text("Email")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .frame(width: 80, height: 32)
                                    .foregroundColor(.blue)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.15))
                            }
                        }
                        .padding(.top, 20)
                        
                    }.padding(.vertical)
                   
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("Feedback")
                            .font(.title2)
                        
                        VStack(alignment: .leading, spacing: 5.0) {
                            Text("We can't wait to hear from you")
                            
                        }
                        .foregroundColor(.gray)
                        
                        HStack(alignment: .bottom, spacing: 20) {
                            Button {
                                email.send(openURL: openURL, toAddress: "jegloprintcontent@gmail.com", subject: "Feedback")
                            } label: {
                                Text("Send Feedback")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .frame(width: 150, height: 32)
                                    .foregroundColor(.blue)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.15))
                            }
                            
                        }
                        .padding(.top, 10)
                    }
                    .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("Prayer Request")
                            .font(.title2)
                        
                        VStack(alignment: .leading, spacing: 5.0) {
                            Text("Do you have a prayer request? We would love to pray along with you.")
                            
                        }
                        .foregroundColor(.gray)
                        
                        HStack(alignment: .bottom, spacing: 20) {
                            Button {
                                email.send(openURL: openURL, toAddress: "guidance@ileewe.org", subject: "Prayer Request")
                            } label: {
                                Text("Send request")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .frame(width: 150, height: 32)
                                    .foregroundColor(.blue)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.15))
                            }
                            
                        }
                        .padding(.top, 10)
                        
                        
                    }
                    
                   
                }
                .padding()
                

            }
            .navigationTitle("More")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            .onAppear(){
                Analytics.logEvent(AnalyticsEventScreenView,
                                   parameters: [AnalyticsParameterScreenName: "More",
                                               AnalyticsParameterScreenClass: "More"])
                
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct MoreViews_Previews: PreviewProvider {
    
    //@State static var selection: Tab = .home
    static var previews: some View {
        MoreViews()
    }
}



func call() {
    let phone = "tel://"
    let phoneNumberformatted = phone + "+2349039650192"
    guard let url = URL(string: phoneNumberformatted) else { return }
    UIApplication.shared.open(url)
}


func sendMail() {
    print(UIDevice.current.systemVersion + UIDevice.current.name)
    print(UIDevice.current.modelName)
    
}


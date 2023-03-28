//
//  LogInScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct LogInScreen: View {
    @AppStorage("isBoardingActive") var isBoardingActive: Bool = false
    @State private var isAnimating: Bool = false
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    var body: some View {
        NavigationView {
            ZStack{
                //MARK: - BACKGROUND
                Image("LoginSignUpBG")
                    .resizable()
                    .scaledToFill()
                
                GeometryReader { geo in
                    VStack{
                        Spacer()
                        //MARK: - IMAGE ICON
                        Image("Time")
                            .resizable()
                            .frame(width: geo.size.width*0.7,height: geo.size.height*0.35)
                            .scaleEffect(isAnimating ? 1 : 1.2)
                            .opacity(isAnimating ? 1 : 0.6)
                        //MARK: - EMAIL TEXTFIELD
                        Group {
                            LogInSignUpTextField(size: geo.size, text: $emailText)
                            
                            
                            //MARK: - PASSWORD TEXTFIELD
                            LogInSignUpTextField(size: geo.size, text: $passwordText)
                            
                            //MARK: - SIGN UP BUTTON
                            HStack{
                                Spacer()
                                Text("New User?")
                                    .foregroundColor(.gray)
                              
                                NavigationLink(destination: SignUpScreen()){
                                    Text("Sign Up")
                                        .foregroundColor(.white)
                                }
                               
                                .padding(.trailing,geo.size.width*0.15)
                                
                            }
                        }
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -20)
                        //MARK: - LOGIN BUTTON
                        Button {
                            isBoardingActive = true
                        } label: {
                            LogInSignUpButton(text: "LOGIN", size: geo.size)
                        }
                        .padding(.vertical,100)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : 20)
                        Spacer()
                        Spacer()
                    }
                }
                .onAppear(){
                    withAnimation(.spring(response: 0.7,dampingFraction: 0.35)){
                        isAnimating = true
                    }
                }
            }
        }
    }
}

struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}

//
//  SignUpScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State var userNameText: String = ""
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State private var isAnimating: Bool = false
    var body: some View {
        ZStack{
            Color.clear
                .background(
                    Image("LoginSignUpBG")
                        .resizable()
                        .blur(radius: 5, opaque: true)
                        .overlay(Color.black
                            .opacity(0.2))
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                )
            GeometryReader { geo in
                VStack {
                    //MARK: - HEADER
                    HStack{
                        VStack(alignment: .leading){
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                GimmickButton(imageName: "arrow.left")
                            }
                            Text("Sign Up")
                                .font(.system(size: 40,design: .rounded))
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                        }
                        Spacer()
                    }.padding(.horizontal,20)
                        .padding(.top)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -20)
                    
                    
                    Spacer()
                    
                    //MARK: - TEXT FIELD
                    HStack{
                        Spacer()
                        VStack(alignment: .leading){
                            Text("USERNAME")
                                .foregroundColor(.white)
                            NormalTextField(size: geo.size, placeHolder: "Username", text: $userNameText)
                            Text("EMAIL")
                                .foregroundColor(.white)
                            NormalTextField(size: geo.size, placeHolder: "Email", text: $emailText)
                            Text("PASSWORD")
                                .foregroundColor(.white)
                            PasswordTextField(size: geo.size, text: $passwordText)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Button {
                        authViewModel.createAccount(username: userNameText, email: emailText, password: passwordText)
                    } label: {
                        LogInSignUpButton(text: "SIGN UP", size: geo.size)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    
                    Spacer()
                    
                }
                
                .navigationBarBackButtonHidden()
            }
        }
        .onAppear(){
            withAnimation(.spring(response: 0.7,dampingFraction: 0.35)){
                isAnimating = true
            }
        }
    }
    
    
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen().preferredColorScheme(.dark)
    }
}

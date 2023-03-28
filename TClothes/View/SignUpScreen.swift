//
//  SignUpScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var usernameText: String = ""
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State private var isAnimating: Bool = false
    var body: some View {
        
        
        ZStack{
            //MARK: - BG
            Image("LoginSignUpBG")
                .resizable()
                .scaledToFill()
                .blur(radius: 5, opaque: true)
                .overlay(Color.black
                    .opacity(0.2))
            
            GeometryReader { geo in
                VStack {
                    //MARK: - HEADER
                    Spacer()
                    
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
                    }.padding(.horizontal,30)
                        .opacity(isAnimating ? 1 : 0)
                        .offset(y: isAnimating ? 0 : -20)
                    
                    
                    //MARK: - TEXT FIELD
                    VStack(alignment: .leading){
                        Text("USERNAME")
                            .foregroundColor(.white)
                        LogInSignUpTextField(size: geo.size, text: $usernameText)
                        Text("EMAIL")
                            .foregroundColor(.white)
                        LogInSignUpTextField(size: geo.size, text: $emailText)
                        Text("PASSWORD")
                            .foregroundColor(.white)
                        LogInSignUpTextField(size: geo.size, text: $passwordText)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .padding(.vertical)
                    
                    Button {
                        
                    } label: {
                        LogInSignUpButton(text: "SIGN UP", size: geo.size)
                    }
                    .opacity(isAnimating ? 1 : 0)
                    .offset(y: isAnimating ? 0 : 20)
                    .padding(.vertical)
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
        SignUpScreen()
    }
}

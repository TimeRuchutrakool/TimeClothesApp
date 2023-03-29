//
//  ContentView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct OnBoardingScreen: View {
    @AppStorage("isBoardingActive") var isBoardingActive: Bool = true
    @State private var isAnimating: Bool = false
    var body: some View {
        
            ZStack{
                
                //MARK: - BACKGROUND
                Group{
                    Image("launchScreenBG")
                        .resizable()
                        .scaledToFill()
                    Color(.white)
                        .opacity(0.15)
                }.edgesIgnoringSafeArea(.all)
                
                //MARK: - CONTENT
                VStack(alignment: .leading) {
                    
                    //MARK: - CONTENT TEXT
                    Spacer()
                    Spacer()
                    Spacer()
                    Group {
                        HStack{
                            Text("With")
                            Text("old")
                                .overlay(RoundedRectangle(cornerRadius: 10).fill(Color("ColorPink")).frame(height: 7))
                            Text("new")
                        }
                        Text("clothes")
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 50,design: .serif))
                    .bold()
                    .offset(y: isAnimating ? 0 : -20)
                    .opacity(isAnimating ? 1 : 0)
                    Spacer()
                    
                    Button {
                        isBoardingActive = false
                    } label: {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("ColorPink"))
                            .frame(minWidth: 120,maxWidth: 190,maxHeight: 70)
                            .overlay(
                                HStack{
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50)
                                        .opacity(0.4)
                                        .overlay(
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.white)
                                            .font(.system(size: 35))
                                        
                                        )
                                    
                                    Text("Get Started")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20,design: .rounded))
                                        .fontWeight(.heavy)
                                }
                            )
                            .offset(y: isAnimating ? 0 : 20)
                            .opacity(isAnimating ? 1 : 0)
                    }
                    
                    
                    Spacer()
                }
                
            }
            .onAppear(){
                withAnimation(.spring(response: 0.7,dampingFraction: 0.35)){
                        isAnimating  = true
                    
                }
            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}

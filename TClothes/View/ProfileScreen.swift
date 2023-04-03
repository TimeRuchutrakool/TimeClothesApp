//
//  ProfileScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct ProfileScreen: View {
    
    @ObservedObject private var authViewModel: AuthViewModel
    init(){
        authViewModel = AuthViewModel()
        authViewModel.getuser()
        
    }
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("ColorSoftGray")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(width: geo.size.width,height: geo.size.height*0.4)
                            .edgesIgnoringSafeArea(.all)
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .frame(width: geo.size.width*0.85,height: geo.size.height*0.28)
                            .offset(y:geo.size.height*0.08)
                            .shadow(radius: 5)
                            .overlay(
                                VStack{
                                    Circle()
                                        .fill(Color.white)
                                        .shadow(radius: 5)
                                        .overlay(
                                            Image(systemName: "heart.fill")
                                                .foregroundColor(Color.accentColor)
                                                .font(.system(size: 70))
                                        )
                                        .padding(.bottom)
                                    Text(authViewModel.customer.username)
                                        .font(.system(.title2,design: .rounded))
                                        .fontWeight(.heavy)
                                    Text(authViewModel.customer.email)
                                        .font(.system(.title3))
                                        .foregroundColor(.gray)
                                }
                            )
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: geo.size.width*0.7,height: geo.size.height*0.4)
                        .shadow(radius: 5)
                        .overlay(
                            VStack{
                                NavigationLink(destination: OrdersScreen()) {
                                    HStack{
                                        Text("Orders").foregroundColor(.gray)
                                        Spacer()
                                        Image(systemName: "basket.fill").foregroundColor(.gray)
                                    }.padding(.horizontal)
                                        .padding(.top)
                                    
                                }
                                Divider()
                                HStack{
                                    Text("Log out").foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(.gray)
                                }.padding(.horizontal)
                                    .onTapGesture {
                                        authViewModel.logOut()
                                    }
                                Spacer()
                            }
                        )
                    Spacer()
                }
            }
            
            
        }
        
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}

//
//  FirstScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct FirstScreen: View {
    @AppStorage("isBoardingActive") var isBoardingActive: Bool = true
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        Group{
            if isBoardingActive{
                OnBoardingScreen()
            }
            else{
                if authModel.user != nil{
                    MainScreen().environmentObject(AuthViewModel())
                }
                else{
                    LogInScreen().environmentObject(AuthViewModel())
                }
            }
        }.onAppear(){
            authModel.listenToAuthState()
        }
    }
}


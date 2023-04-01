//
//  ProfileScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct ProfileScreen: View {
    @AppStorage("isBoardingActive") var isBoardingActive: Bool = false
    @ObservedObject private var authViewModel: AuthViewModel
    init(){
        authViewModel = AuthViewModel()
    }
    var body: some View {
        VStack {
            Button {
                authViewModel.logOut()
            } label: {
                Text("Log Out")
            }
            
            Button {
                isBoardingActive = true
            } label: {
                Text("Boarding Active")
            }

        }
        
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}

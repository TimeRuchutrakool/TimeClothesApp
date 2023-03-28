//
//  FirstScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct FirstScreen: View {
    @AppStorage("isBoardingActive") var isBoardingActive: Bool = true
    var body: some View {
        if isBoardingActive{
            OnBoardingScreen()
        }
        else{
            LogInScreen()
        }
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}

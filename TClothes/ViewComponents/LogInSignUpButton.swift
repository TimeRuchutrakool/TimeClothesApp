//
//  LogInSignUpButton.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct LogInSignUpButton: View {
    var text: String
    var size: CGSize
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color("ColorPink"))
            .frame(width: size.width*0.5,height: 60)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 30,design: .rounded)))
    }
}

struct LogInSignUpButton_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpButton(text: "LOGIN", size: CGSize(width: 300, height: 60))
    }
}

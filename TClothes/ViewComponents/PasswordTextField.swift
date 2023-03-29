//
//  PasswordTextField.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct PasswordTextField: View {
    var size: CGSize
    @Binding var text: String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .opacity(0.95)
            .frame(width: size.width*0.8,height: 60)
            .overlay(
                SecureField("Password", text: $text).padding()
            )
            .padding(.vertical)
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(size: .zero, text: .constant(""))
    }
}

//
//  LogInTextField.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct LogInSignUpTextField: View {
    var size: CGSize
    @Binding var text: String
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .opacity(0.95)
            .frame(width: size.width*0.8,height: 60)
            .overlay(
                TextField("Email", text: $text).padding()
            )
            .padding(.vertical)
    }
}

struct LogInTextField_Previews: PreviewProvider {
    static var previews: some View {
        LogInSignUpTextField(size: CGSize(width: 100, height: 10), text: .constant(""))
    }
}

//
//  GimmickButton.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/28/23.
//

import SwiftUI

struct GimmickButton: View {
    var imageName: String
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .frame(width: 50,height: 50)
            .shadow(radius: 3)
            .overlay(
                Image(systemName: imageName)
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .fontWeight(.heavy))
    }
}

struct GimmickButton_Previews: PreviewProvider {
    static var previews: some View {
        GimmickButton(imageName: "arrow.left").previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}

//
//  PinkImageButton.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/30/23.
//

import SwiftUI

struct PinkImageButton: View {
    let image: String
    let text: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color("ColorPink"))
            .frame(minWidth: 120,maxWidth: 220,maxHeight: 70)
            .overlay(
                HStack{
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 50)
                        .opacity(0.4)
                        .overlay(
                        Image(systemName: image)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                        
                        )
                    
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 25,design: .rounded))
                        .fontWeight(.heavy)
                }
            )
    }
}

struct PinkImageButton_Previews: PreviewProvider {
    static var previews: some View {
        PinkImageButton(image: "arrow.right", text: "Get Started")
    }
}

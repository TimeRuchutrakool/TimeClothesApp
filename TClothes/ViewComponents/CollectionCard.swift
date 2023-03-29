//
//  CollectionCard.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct CollectionCard: View {
    let image: String
    let collectionName: String
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: 190,height: 250)
            .cornerRadius(16)
            .overlay(
            Rectangle()
                .cornerRadius(16, corners: [.bottomLeft,.bottomRight])
                .frame(width: 190,height: 60)
                .opacity(0.3)
                .overlay(
                    Text(collectionName)
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                        
                )
            ,alignment: .bottom
            )
            .shadow(radius: 6)
    }
}

struct CollectionCard_Previews: PreviewProvider {
    static var previews: some View {
        CollectionCard(image: "summer", collectionName: "Autumn")
    }
}

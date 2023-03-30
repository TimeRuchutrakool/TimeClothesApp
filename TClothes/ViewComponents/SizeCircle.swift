//
//  SizeCircle.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/30/23.
//

import SwiftUI

struct SizeCircle: View {
    let sizeOfCircle: Size
    @Binding var selectedSize: Size
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor.opacity(selectedSize == sizeOfCircle ? 1 : 0))
                .frame(maxWidth: .infinity)
            Text(sizeOfCircle.sizeString)
                .font(.system(size: 30))
                .foregroundColor(selectedSize == sizeOfCircle ? .white : .gray)
        }
    }
}

struct SizeCircle_Previews: PreviewProvider {
    static var previews: some View {
        SizeCircle(sizeOfCircle: .S, selectedSize: .constant(.S)).previewLayout(.sizeThatFits)
    }
}

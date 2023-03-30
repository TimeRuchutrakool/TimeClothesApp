//
//  CategoriesView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/30/23.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [Categories]
    @Binding var isShowCategory: Bool
    var body: some View {
        
        GeometryReader{ geo in
            VStack(alignment: .trailing){
                Button {
                    withAnimation(.spring()){
                        isShowCategory = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
                Text("Categories")
                    .font(.system(size: 25))
                    .fontWeight(.heavy)
                    .padding(.vertical)
                ForEach(categories) { category in
                    NavigationLink(destination: SharedProductScreen(category: category.category)){
                        Text(category.category)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .padding(.bottom)
                    }
                }
                
                Spacer()
            }.frame(width: geo.size.width*0.5,height: geo.size.height)
                .background(.ultraThinMaterial)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    
    static var previews: some View {
        CategoriesView(categories: [], isShowCategory: .constant(true)).previewLayout(.sizeThatFits)
    }
}

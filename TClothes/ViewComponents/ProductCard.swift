//
//  ProductCardView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI
//.frame(width: 200,height:320)
struct ProductCard: View {
    let product: Product
    var body: some View {
        
            VStack{
                AsyncImage(url: URL(string: product.imageURL)){ image in
                    NavigationLink(destination: ProductDetailScreen(product: product)) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 140,maxWidth: 170,minHeight: 200,maxHeight: 230)
                                .cornerRadius(16)
                                .padding()
                        }
                    } placeholder: {
                        VStack {
                            Spacer()
                            Image("loadingIcon")
                                .resizable()
                                .cornerRadius(15)
                                .frame(width: 150,height: 150)
                                .padding()
                            Spacer()
                            
                        }
                    }
                HStack{
                    VStack(alignment: .leading){
                        Text(product.productName)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(String(format: "$%.2f", product.price))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Circle()
                        .fill(Color("ColorPink"))
                        .frame(width: 40)
                        .overlay(Image(systemName: "heart")
                            .font(.system(size: 20))
                            .foregroundColor(.white))
                }
                .padding(.horizontal)
                
            }
            .frame(minWidth: 150,maxWidth: 180,minHeight: 300,maxHeight: 330)
            .background(.clear)
            .shadow(radius: 5)
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product()).previewLayout(.sizeThatFits).background(.black)
        
    }
}

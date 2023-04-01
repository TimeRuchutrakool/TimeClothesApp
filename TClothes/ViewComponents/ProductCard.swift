//
//  ProductCardView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @State private var isWish: Bool = false
    @ObservedObject private var productViewModel:ProductsViewModel
    @State private var wishAnimating: Bool = false
    init(product: Product){
        self.product = product
        productViewModel = ProductsViewModel()
        
    }
    
    var body: some View {
        
            VStack{
                AsyncImage(url: URL(string: product.imageURL)){ image in
                    NavigationLink(destination: ProductDetailScreen(product: product)) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 160,maxWidth: 170,minHeight: 200,maxHeight: 230)
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
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(String(format: "$%.2f", product.price))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Circle()
                        .fill(Color("ColorPink"))
                        .frame(width: 40)
                        .overlay(
                            Image(systemName:isWish ? "heart.fill" : "heart")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .scaleEffect(wishAnimating ? 2 : 1)
                        )
                    
                        .onTap {
                            withAnimation(.spring()){
                                wishAnimating = true
                            }
                        } onEnded: {
                            withAnimation(.spring()){
                                wishAnimating = false
                                isWish.toggle()
                                product.isWish = isWish
                                
                                if product.isWish {
                                    productViewModel.addWishList(productID: product.id)
                                }
                                else{
                                    productViewModel.removeWishList(productID: product.id)
                                }
                            }
                        }
                }
                .padding(.horizontal)
                
            }
            .frame(minWidth: 170,maxWidth: 180,minHeight: 300,maxHeight: 330)
            .background(.clear)
            .shadow(radius: 5)
            .onAppear(){
                isWish = product.isWish
            }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product()).previewLayout(.sizeThatFits).background(.black)
        
    }
}

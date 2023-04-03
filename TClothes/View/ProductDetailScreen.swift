//
//  ProductDetailScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/30/23.
//

import SwiftUI

enum Size{
    case S
    case M
    case L
    case XL
    
    var sizeString: String{
        switch self{
        case .S:
            return "S"
        case .M:
            return "M"
        case .L:
            return "L"
        case .XL:
            return "XL"
        }
    }
}

struct ProductDetailScreen: View {
    @Environment(\.presentationMode) var presentaionMode: Binding<PresentationMode>
    @ObservedObject private var productViewModel: ProductsViewModel = ProductsViewModel()
    @State private var selectedSize: Size = .M
    let product: Product
   
    var body: some View {
        ZStack{
            Color("ColorSoftGray")
                .edgesIgnoringSafeArea(.all)
            VStack{
                //MARK: - Header Button
                HStack{
                    Button {
                        presentaionMode.wrappedValue.dismiss()
                    } label: {
                        GimmickButton(imageName: "arrow.left")
                    }
                    Spacer()
                    
                }//HStack
                .padding(.horizontal,25)
                .padding(.vertical)
                //MARK: - Header Text
                Text(product.productName)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Text(product.category)
                    .foregroundColor(.gray)
                
                HStack{
                    //MARK: - Image
                    AsyncImage(url: URL(string: product.imageURL)) { image in
                        image
                            .resizable()
                            .frame(height: 300)
                            .scaledToFit()
                            .cornerRadius(16)
                            .shadow(radius: 5)
                            .padding()
                    } placeholder: {
                        Image("loadingIcon")
                            .resizable()
                            .cornerRadius(15)
                            .frame(width: 200,height: 200)
                            .padding()
                        
                    }
                    //MARK: - Size
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .frame(width: 70,height: 300)
                        .overlay(
                            VStack{
                                
                                SizeCircle(sizeOfCircle: .S, selectedSize: $selectedSize)
                                    .onTapGesture {
                                        withAnimation(.easeOut){
                                            selectedSize = .S
                                        }
                                        
                                    }
                                SizeCircle(sizeOfCircle: .M, selectedSize: $selectedSize)
                                    .onTapGesture {
                                        withAnimation(.easeOut){
                                            selectedSize = .M
                                        }
                                    }
                                SizeCircle(sizeOfCircle: .L, selectedSize: $selectedSize)
                                    .onTapGesture {
                                        withAnimation(.easeOut){
                                            selectedSize = .L
                                        }
                                    }
                                SizeCircle(sizeOfCircle: .XL, selectedSize: $selectedSize)
                                    .onTapGesture {
                                        withAnimation(.easeOut){
                                            selectedSize = .XL
                                        }
                                    }
                            }
                        )//Rounded Rectangle
                }
                .padding()
                //MARK: - Footer
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        Text("Price")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                            .fontWeight(.heavy)
                        Text(String(format: "$%.2f", product.price))
                            .font(.system(size: 20))
                            .bold()
                    }
                    
                    Spacer()
                    Button {
                        productViewModel.addProductToCart(productID: product.id, size: selectedSize.sizeString)
                    } label: {
                        PinkImageButton(image: "basket.fill", text: "Add to cart")
                        
                    }                     
                }
                .padding(.horizontal,40)
                Spacer()
            }//VStack
        }//ZStack
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {

    static var previews: some View {
        let product = Product()
        product.productName = "Blue Shirt"
        product.category = "Shirt"
        product.imageURL = "https://firebasestorage.googleapis.com/v0/b/timeclothes-f9b94.appspot.com/o/Products%2FUxLrntYsMp8NUMIXC6k9.jpg?alt=media&token=e7519e9b-e6f5-471d-8dc1-9940c0b51590"
        product.price = 15.98
        product.new = true
        product.collection = "Summer"

        return ProductDetailScreen (product: product)
    }
}

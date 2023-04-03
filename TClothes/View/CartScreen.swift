//
//  CartScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/2/23.
//

import SwiftUI

struct CartScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var productViewModel: ProductsViewModel
    @State private var quantity: Int = 0
  
    init(){
        productViewModel = ProductsViewModel()
        productViewModel.getCartItems()
    
    }
    var body: some View {
        ZStack{
            Color("ColorSoftGray")
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geo in
                VStack{
                    HStack{
                        Button {
                            withAnimation(.spring()){
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            GimmickButton(imageName: "arrow.left")
                        }
                        Text("My Cart")
                            .font(.system(.largeTitle))
                            .fontWeight(.heavy)
                            .padding(.horizontal)
                        Spacer()
                    }.padding(.horizontal,25)
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        
                        ForEach(productViewModel.cartItems,id: \.id) { item in
                            
                            CartItemView(geo:geo,item:item).environmentObject(productViewModel)
                        }
                        
                    }
                    NavigationLink(destination: CheckOutScreen()) {
                        PinkImageButton(image: "heart", text: "Check Out")
                            .scaleEffect(0.8)
                          
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
        
    }
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen()
    }
}

struct CartItemView: View {
    var geo: GeometryProxy
    var item: CartItem
    
    @EnvironmentObject private var productViewModel: ProductsViewModel
    @State private var quantity: Int = 0
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(width: geo.size.width*0.8,height: geo.size.height*0.2)
            .overlay(
                HStack{
                    AsyncImage(url: URL(string: item.product.imageURL)){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(16)
                            .frame(width: geo.size.width*0.35)
                            .padding(.vertical)
                        
                    } placeholder: {
                        VStack {
                            Spacer()
                            Image("loadingIcon")
                                .resizable()
                                .cornerRadius(15)
                                .frame(width: 100,height: 100)
                                .padding()
                            Spacer()
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text(item.product.productName)
                                .font(.system(.title3))
                                .bold()
                            Spacer()
                        }.padding(.vertical)
                        
                        HStack {
                            Text(String(format: "$%.2f", item.product.price))
                                .font(.system(.title2))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            
                            Text(item.size)
                                .font(.system(.title3))
                                .fontWeight(.heavy)
                            Spacer()
                            Button {
                                quantity -= 1
                                if quantity <= 0{
                                    quantity = 0
                                }
                                productViewModel.removeProductToCart(productID: item.product.id, size: item.size)
                                
                                
                            } label: {
                                Image(systemName: "minus")
                                    .foregroundColor(Color.accentColor)
                            }
                            Text("\(quantity)").foregroundColor(Color.gray)
                            Button {
                                quantity += 1
                                productViewModel.addProductToCart(productID: item.product.id, size: item.size)
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.accentColor)
                            }
               
                        }
                        .padding(.vertical)
                        .padding(.trailing)
                    }
                    Spacer()
                }
            )
            .onAppear(){
                quantity = item.quantity
                
            }
    }
}

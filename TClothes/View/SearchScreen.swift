//
//  SearchScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct SearchScreen: View {
    @State private var searchText: String = ""
    
    @ObservedObject private var productViewModel: ProductsViewModel
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    @State var isActive : Bool = false
    init(){
        productViewModel = ProductsViewModel()
        productViewModel.getCartItems()
    }
    var body: some View {
        
        ZStack{
            GeometryReader{ geo in
                Color("ColorSoftGray")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .opacity(0.95)
                            .frame(width: geo.size.width*0.8,height: 50)
                            .overlay(
                                TextField("Search", text: $searchText).padding()
                            )
                            .padding(.vertical)
                            .shadow(radius: 3)
                            .onSubmit {
                                productViewModel.getProductByFilter(field: "productname", value: searchText)
                            }
                        NavigationLink(destination: CartScreen(rootIsActive: $isActive),isActive: $isActive) {
                            GimmickButton(imageName: "cart.fill")
                                .overlay(
                                        Circle()
                                            .fill(Color.accentColor)
                                            .frame(width: 20)
                                            .overlay(
                                                Text(String(describing: productViewModel.cartItems.count))
                                                    .foregroundColor(.white)
                                            )   
                                    ,alignment: .topTrailing
                                )
                        }.isDetailLink(false)
                        
                        
                        Spacer()
                    }
                    
                    if productViewModel.products.isEmpty{
                        Spacer()
                        
                        Text("Not Found")
                            .foregroundColor(.black)
                            .font(.system(size: 40,design: .rounded))
                            .fontWeight(.heavy)
                        Circle()
                            .fill(Color.accentColor)
                            .frame(width: 220)
                            .overlay(
                                Image("character")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 180)
                                    .shadow(radius: 10,x:5,y:5)
                                
                            )
                        
                        
                        Spacer()
                    }
                    else{
                        ScrollView(.vertical,showsIndicators: false){
                            LazyVGrid(columns: columns) {
                                ForEach(productViewModel.products) { product in
                                    NavigationLink(destination: ProductDetailScreen(product: product)) {
                                        ProductCard(product: product)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
        .onAppear(){
            productViewModel.getProductByFilter(field: "productname", value: searchText)
            productViewModel.getCartItems()
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}


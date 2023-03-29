//
//  HomeScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject private var productViewModel = ProductsViewModel()
    var body: some View {
        ZStack{
            Color("ColorSoftGray")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                //MARK: - Header
                HStack{
                    GimmickButton(imageName: "text.justify")
                    Spacer()
                    GimmickButton(imageName: "cart.fill")
                }.padding(.horizontal,25)
                    .padding(.vertical)
                ScrollView(.vertical,showsIndicators: false){
                    //MARK: - New Arrival
                    HStack{
                        Text("New Arrival")
                            .font(.system(size: 30,design: .rounded))
                            .fontWeight(.heavy)
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("See all")
                                .foregroundColor(.gray)
                        }
                        
                    }.padding(.horizontal,25)
                        .padding(.top)
                    //MARK: - New Arrival Scroll View
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 15){
                            ForEach(productViewModel.newArrivalProduct) { product in
                                ProductCard(image: product.imageURL, productName: product.productName, price: "\(product.price)")
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    //MARK: - Collection
                    HStack{
                        Text("Collection")
                            .font(.system(size: 30,design: .rounded))
                            .fontWeight(.heavy)
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("See all")
                                .foregroundColor(.gray)
                        }
                        
                    }.padding(.horizontal,25)
                        .padding(.top)
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(spacing: 25){
                            CollectionCard(image: "winter", collectionName: "Winter")
                            CollectionCard(image: "summer", collectionName: "Summer")
                            CollectionCard(image: "fall", collectionName: "Fall")
                            CollectionCard(image: "spring", collectionName: "Spring")
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                
            }
            
        }
        .onAppear(){
            productViewModel.getNewArrivalProduct()
        }
        .padding(.bottom,UIScreen.main.bounds.height*0.01)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

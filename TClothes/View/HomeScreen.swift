//
//  HomeScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject private var productViewModel: ProductsViewModel
    @State private var isShowCategories = false
    
    init(){
        productViewModel = ProductsViewModel()
        productViewModel.getProductByFilter(field: "new", value: true)
        productViewModel.getCategories()
    }
    
    var body: some View {
        ZStack{
            Color("ColorSoftGray")
                .edgesIgnoringSafeArea(.all)
            ZStack{
                VStack{
                    //MARK: - Header
                    HStack{
                        Button {
                            withAnimation(.spring()){
                                isShowCategories = true
                            }
                        } label: {
                            GimmickButton(imageName: "text.justify")
                        }
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
                            NavigationLink(destination: SharedProductScreen(filter: "new", value: true)) {
                                Text("See all")
                                    .foregroundColor(.gray)
                            }
                        }.padding(.horizontal,25)
                            .padding(.top)
                        //MARK: - New Arrival Scroll View
                        
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing: 15){
                                ForEach(productViewModel.products) { product in
                                    ProductCard(product: product)
                                        .padding(.vertical)
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
                                ForEach(Constant.collections,id: \.self) { collection in
                                    NavigationLink(destination: SharedProductScreen(filter: "collection", value: collection)) {
                                        CollectionCard(image: collection, collectionName: collection)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        Spacer()
                    }
                    
                }
                //MARK: - Categories View
                CategoriesView(categories: productViewModel.categories, isShowCategory: $isShowCategories)
                    .offset(x:isShowCategories ? 0 : -UIScreen.main.bounds.width)
            }
        }
        .onAppear(){
            isShowCategories = false
            
        }
        .padding(.bottom,UIScreen.main.bounds.height*0.01)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

//
//  SharedProductScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/30/23.
//

import SwiftUI

struct SharedProductScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let filter: String
    let value: Any
    @ObservedObject private var productViewModel = ProductsViewModel()
    let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ZStack{
            Color("ColorSoftGray")
                .edgesIgnoringSafeArea(.all)
            VStack{
                //MARK: - Header Button
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        GimmickButton(imageName: "arrow.left")
                    }
                    Spacer()
                    Text(value is Bool ? "New Arrival" : value as? String ?? filter)
                        .font(.headline)
                        .bold()
                    Spacer()
                    Button {
                        
                    } label: {
                        GimmickButton(imageName: "cart.fill")
                    }
                    
                }//HStack
                .padding(.horizontal,25)
                .padding(.vertical)
                
                ScrollView(.vertical,showsIndicators: false){
                    LazyVGrid(columns: columns) {
                        ForEach(productViewModel.products) { product in
                            NavigationLink(destination: ProductDetailScreen(product: product)) {
                                ProductCard(product: product)
                                    
                            }
                        }
                    }
                }
                .refreshable {
                    productViewModel.getProductByFilter(field: filter,value: value)
                }
            }
        }
        .onAppear(){
            productViewModel.getProductByFilter(field: filter,value: value)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SharedProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        SharedProductScreen(filter: "category", value: "Shirt")
    }
}

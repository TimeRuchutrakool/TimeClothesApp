//
//  CheckOutScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/3/23.
//

import SwiftUI

struct CheckOutScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject private var productViewModel: ProductsViewModel = ProductsViewModel()
   
    
    var body: some View {
        ZStack {
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
                        Text("Check Out")
                            .font(.system(.title))
                            .fontWeight(.heavy)
                            .padding(.horizontal)
                        Spacer()
                    }.padding(.horizontal,25)
                        .padding(.vertical)
                    
                    HStack {
                        Text("Total")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                        Spacer()
                    }.padding(.leading)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: geo.size.width*0.8,height: geo.size.height*0.2)
                    
                        .overlay(
                            VStack(spacing: 20){
                                HStack{
                                    Text("Products")
                                    Spacer()
                                    Text(String(format: "$%.2f", productViewModel.totalPrice))
                                }
                                .padding(.horizontal).padding(.top)
                                
                                HStack{
                                    Text("Total")
                                    Spacer()
                                    Text(String(format: "$%.2f", productViewModel.totalPrice))
                                }
                                .padding(.horizontal)
                                Button {
                                    
                                    productViewModel.addOrder(cartItems: productViewModel.cartItems)
                                } label: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.accentColor)
                                        .overlay(Text("Pay").foregroundColor(.white))
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                }

                            }
                        )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            productViewModel.getCartItems()
            productViewModel.getTotalPrice()
        }
    }
}


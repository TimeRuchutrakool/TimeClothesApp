//
//  OrdersScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/3/23.
//

import SwiftUI

struct OrdersScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var productViewModel: ProductsViewModel
    init(){
        productViewModel = ProductsViewModel()
        productViewModel.getOrders()
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
                        Text("My Orders")
                            .font(.system(.title))
                            .fontWeight(.heavy)
                            .padding(.horizontal)
                        Spacer()
                    }.padding(.horizontal,25)
                        .padding(.vertical)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(productViewModel.orders.sorted(by: {$0.date.compare($1.date) == .orderedDescending}),id: \.id) { item in
                            NavigationLink(destination: OrderDetailScreen(order: item)) {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .frame(width: geo.size.width*0.85,height: geo.size.height*0.27)
                                    .shadow(radius: 5)
                                    .overlay(
                                        VStack {
                                            HStack {
                                                Text(item.dateString)
                                                    .font(.title3)
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.black)
                                                Spacer()
                                            }
                                            .padding([.top,.leading])
                                            HStack {
                                                Text("Order No. \(item.orderID)")
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                                Spacer()
                                            }
                                            .padding(.leading)
                                            Divider()
                                            HStack{
                                                ForEach(item.items.prefix(4)) { item in
                                                    AsyncImage(url: URL(string: item.imageURL)){ image in
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: geo.size.height*0.15)
                                                            .cornerRadius(16)
                                                    } placeholder: {
                                                        Image("loadingIcon")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(height: geo.size.height*0.15)
                                                        
                                                    }
                                                    
                                                }
                                                Spacer()
                                            }
                                            .padding([.leading,.bottom])
                                        }
                                    )
                                
                                    .padding()
                                
                            }
                            
                                
                        }
                    }
                    
                    
                    
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct OrdersScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrdersScreen()
    }
}

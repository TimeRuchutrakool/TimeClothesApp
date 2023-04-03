//
//  OrderDetailScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/3/23.
//

import SwiftUI

struct OrderDetailScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let order: Order
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
                                .padding(.trailing)
                        }
                        VStack(alignment:.leading) {
                            Text("Order No.")
                                .font(.system(.title))
                                .fontWeight(.heavy)
                               
                            Text(order.orderID)
                                .font(.system(.subheadline))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }.padding(.horizontal,25)
                        .padding(.vertical)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(width: geo.size.width*0.9,height: geo.size.height*0.85)
                        .overlay(
                            ScrollView(showsIndicators: false) {
                                VStack{
                                    ForEach(order.items) { item in
                                        HStack {
                                            AsyncImage(url: URL(string: item.imageURL)){ image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(16)
                                                    .frame(width: geo.size.width*0.35)
                                                    .padding(.vertical)
                                                    .padding(.leading)
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
                                            Spacer()
                                            HStack{
                                                VStack(alignment:.leading,spacing: 10){
                                                    Text(item.productName)
                                                        .font(.system(.title3))
                                                        .bold()
                                                    
                                                    Text(item.priceString)
                                                        .font(.system(.title3))
                                                        .fontWeight(.semibold)
                                                    HStack {
                                                        Text(item.size)
                                                            .font(.system(.title3))
                                                        .fontWeight(.heavy)
                                                        Text("x\(item.quantity)")
                                                    }
                                                }
                                                Spacer()
                                            }
                                        }
                                        Divider()
                                            .frame(width: geo.size.width*0.6)
                                            .background(Color.accentColor)
                                    }
                                    
                                    HStack{
                                        Text("Total")
                                            .font(.system(.title3))
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Text(order.totalPrice)
                                            .font(.system(.title3))
                                            .fontWeight(.semibold)
                                    }.padding()
                                }
                                //VStack
                            }
                        )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OrderDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailScreen(order: Order())
    }
}

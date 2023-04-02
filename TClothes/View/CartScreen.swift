//
//  CartScreen.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/2/23.
//

import SwiftUI

struct CartScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    private var array = ["Apple","Microsoft","Apple","Microsoft","Apple","Microsoft"]
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
                        
                        ForEach(array,id: \.self) { item in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .frame(width: geo.size.width*0.8,height: geo.size.height*0.2)
                                .overlay(
                                    HStack{
                                        Image("Summer")
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(16)
                                            .frame(width: geo.size.width*0.35)
                                            .padding(.vertical)
                                        VStack{
                                            HStack{
                                                Text(item)
                                                    .font(.system(.title3))
                                                    .bold()
                                                Spacer()
                                            }.padding(.vertical)
                                            Spacer()
                                            HStack {
                                                Text("$49.99")
                                                    .font(.system(.title2))
                                                    .fontWeight(.semibold)
                                                Spacer()
                                            }
                                            Spacer()
                                            HStack {
                                                
                                                Text("L")
                                                    .font(.system(.title3))
                                                    .fontWeight(.heavy)
                                                Spacer()
                                                
                                                Circle()
                                                    .stroke(lineWidth: 2)
                                                    .overlay(Image(systemName: "minus"))
                                                    .foregroundColor(Color.accentColor)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(lineWidth: 0.5)
                                                    .frame(width: 30)
                                                    .overlay(Text("2").foregroundColor(Color.gray))
                                                Circle()
                                                    .stroke(lineWidth: 2)
                                                    .overlay(Image(systemName: "plus"))
                                                    .foregroundColor(Color.accentColor)
                                                
                                            }
                                            .padding(.vertical)
                                            .padding(.trailing)
                                        }
                                        Spacer()
                                    }
                                )
                        }
                        
                    }
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
                            VStack{
                                HStack{
                                    Text("Products")
                                    Spacer()
                                    Text("$146.97")
                                }
                                .padding(.horizontal).padding(.top)
                                HStack{
                                    Text("Discounts")
                                    Spacer()
                                    Text("-$10.00")
                                }
                                .padding(.horizontal)
                                HStack{
                                    Text("Total")
                                    Spacer()
                                    Text("136.97")
                                }
                                .padding(.horizontal)
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.accentColor)
                                    .overlay(Text("Pay").foregroundColor(.white))
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    
                            }
                        )
                    
                    
                    
                }
                
            }
        }
    }
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen()
    }
}

//
//  ProductCardView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 3/29/23.
//

import SwiftUI
//.frame(width: 200,height:320)
struct ProductCard: View {
    let image: String
    let productName: String
    let price: String
    var body: some View {
        
            VStack{
                    AsyncImage(url: URL(string: image)){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 190,height: 250)
                            .cornerRadius(16)
                            .padding()
                        
                    } placeholder: {
                        VStack {
                            Spacer()
                            Image("loadingIcon")
                                .resizable()
                                .cornerRadius(15)
                                .frame(width: 150,height: 150)
                                .padding()
                            Spacer()
                            
                        }
                    }
                HStack{
                    VStack(alignment: .leading){
                        Text(productName)
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                        Text("$\(price)")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Circle()
                        .fill(Color("ColorPink"))
                        .frame(width: 40)
                        .overlay(Image(systemName: "heart")
                            .font(.system(size: 20))
                            .foregroundColor(.white))
                }
                .padding(.horizontal)
                
            }
            .frame(width: 200,height: 350)
            .background(.clear)
            .shadow(radius: 10)
            .padding(.vertical)
            
            
        
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(image: "https://www.brighttv.co.th/wp-content/uploads/2022/07/jennierubyjane_263116473_231156495671731_8959309865840505753_n-822x1024.jpg",productName: "Jennie",price: "48.99").previewLayout(.sizeThatFits).background(.black)
        
    }
}

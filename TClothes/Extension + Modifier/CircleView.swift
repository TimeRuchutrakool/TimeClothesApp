//
//  CircleView.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/1/23.
//

import SwiftUI

struct CircleView: View {
    
    
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    var body: some View {
        ZStack{
            
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth:40)
                .frame(width: 260,height: 260,alignment: .center)
            
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 80)
                .frame(width: 260,height: 260,alignment: .center)
            
        }//: ZSTACK
        
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            CircleView(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}

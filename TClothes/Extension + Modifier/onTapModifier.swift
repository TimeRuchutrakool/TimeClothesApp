//
//  onTapModifier.swift
//  TClothes
//
//  Created by Time Ruchutrakool on 4/1/23.
//


import SwiftUI

struct TapModifier: ViewModifier{
    
    var onPressed: () -> ()
    var onEnded: () -> ()
    func body(content: Content) -> some View {
        content.gesture(
        DragGesture(minimumDistance: 0)
            .onChanged({ _ in
                onPressed()
            })
            .onEnded({ _ in
                onEnded()
            })
        )
    }
}

extension View{
    func onTap(onPressed: @escaping () -> (),onEnded: @escaping () -> ()) -> some View{
        modifier(TapModifier(onPressed: onPressed, onEnded: onEnded))
    }
}

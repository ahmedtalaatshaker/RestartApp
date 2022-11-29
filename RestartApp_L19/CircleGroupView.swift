//
//  RingView.swift
//  RestartApp_L19
//
//  Created by Ahmed Talaat on 27/11/2022.
//

import SwiftUI

struct CircleGroupView: View {
    @State var color: Color
    @State var MinlineWidth: CGFloat
    @State var MaxlineWidth: CGFloat
    @State var opacity: Double
    @State private var isAnimating = false
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(color.opacity(opacity), lineWidth: MinlineWidth)
                .frame(width: 260, height: 260, alignment: .center)
            
            Circle()
                .stroke(color.opacity(opacity), lineWidth: MaxlineWidth)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CircleGroupView(color: .blue, MinlineWidth: 40, MaxlineWidth: 80, opacity: 0.2)
    }
}

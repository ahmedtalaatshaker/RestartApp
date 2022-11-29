//
//  HomeView.swift
//  RestartApp_L19
//
//  Created by Ahmed Talaat on 27/11/2022.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive = false
    @State private var isAnimating = false
    
    // MARK: - Body

    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // MARK: - MIDDLE
            
            VStack {
                ZStack{
                    CircleGroupView(color: .gray, MinlineWidth: 40, MaxlineWidth: 80, opacity: 0.1)

                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .offset(y: isAnimating ? 35 : -35)
                        .animation(
                            .easeInOut(duration: 4)
                            .repeatForever()
                            , value: isAnimating)
                }//: ZStack
                
                Text("the time that leads to mastery is dependent on the intenisity of out focus")
                .foregroundColor(.secondary)
                .font(.system(.title3))
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()

            }//: MIDDLE VStack
            
            
            Spacer()
            // MARK: - BOTTOM
            
            Button {
                withAnimation {
                    isOnboardingViewActive = true
                    AudioPlayer.shared.playSound(sound: "success", type: "m4a")
                }

            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .foregroundColor(.white)
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3,design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }//: BOTTOM
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

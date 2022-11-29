//
//  OnBoardingView.swift
//  RestartApp_L19
//
//  Created by Ahmed Talaat on 27/11/2022.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive = true
    @State private var buttonWidth = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle = "Share."

    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()
                // MARK: - HEADER
                VStack(alignment: .center, spacing: 10){
                    Text(textTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                         it's not how much you give but
                        how much love we put into giving
                        """)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: - CENTER
                ZStack{
                    ZStack{
                        CircleGroupView(color: .white, MinlineWidth: 40, MaxlineWidth: 80, opacity: 0.2)
                            .offset(x: -imageOffset.width, y: 0)
                            .blur(radius: abs(imageOffset.width) / 5)
                            .animation(.easeOut(duration: 1), value: imageOffset)

                    } //: ZStack
                    
                        Image("character-1")
                            .resizable()
                            .scaledToFit()
                            .opacity(isAnimating ? 1 : 0)
                            .animation(.easeOut(duration: 1), value: isAnimating)
                            .offset(x: imageOffset.width * 1.2, y: 0)
                            .rotationEffect(.degrees(Double(imageOffset.width / 10)))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        if abs(imageOffset.width) <= 150{
                                            imageOffset = gesture.translation
                                        }
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                
                                    .onEnded({ _ in
                                        imageOffset = .zero
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 1
                                            textTitle = "Share."
                                        }
                                    })
                            )
                            .animation(.easeOut(duration: 1), value: imageOffset)
                }//: CENTER
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                Spacer()

                // MARK: - FOOTER
                ZStack{
                    // PARTS OF THE CUSTOM BUTTON
                    
                    // 1. BACGROUND (STATIC)
                    Capsule()
                        .fill(.white.opacity(0.2))

                    Capsule()
                        .fill(.white.opacity(0.2)).padding(8)

                    
                    // 2. CALL-TO-ACTION (STATIC)
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                        
                    // 3. CAPSULE (DYNAMIC WIDTH)
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }//: HStack
                    
                    // 4. CIRCLE (DRAGGABLE)
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(10)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80{
                                        buttonOffset = gesture.translation.width
                                    }
                                })
                            
                                .onEnded({ gesture in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            AudioPlayer.shared.playSound(sound: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 80
                                            isOnboardingViewActive = false
                                        }else{
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                        )
                        Spacer()
                    }//: HStack
                }//: FOOTER
                .frame(width: buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                

            }//: VStack
        }//: ZStack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

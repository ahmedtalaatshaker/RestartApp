//
//  ContentView.swift
//  RestartApp_L19
//
//  Created by Ahmed Talaat on 27/11/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - save in userDefaults if not exist
    @AppStorage("onboarding") var isOnboardingViewActive = true
    
    var body: some View {
        ZStack{
            if isOnboardingViewActive {
                OnBoardingView()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

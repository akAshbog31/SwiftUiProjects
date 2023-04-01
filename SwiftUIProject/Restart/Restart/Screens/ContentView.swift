//
//  ContentView.swift
//  Restart
//
//  Created by mac on 01/04/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarging") var isOnboardingViewIsActive: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewIsActive {
                OnboardingView()
            } else {
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

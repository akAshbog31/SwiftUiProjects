//
//  HomeView.swift
//  Restart
//
//  Created by mac on 01/04/23.
//

import SwiftUI

struct HomeView: View {
    //MARK: - PROPERTY
    @AppStorage("isOnboarging") var isOnboardingViewIsActive: Bool = false
    @State private var isAnimating: Bool = false
    
    //MARK: - FUNCTION
    
    //MARK: BODY
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - HEADER
            Spacer()
            
            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(Animation
                            .easeInOut(duration: 4)
                            .repeatForever(), value: isAnimating)
            }
            
            //MARK: - CENTER
            Text("The time that leads to mastery is depends on the intencity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - FOOTER
            Spacer()
            
            Button {
                withAnimation(Animation.easeInOut(duration: 0.4)) {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewIsActive = true
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: Vstack
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

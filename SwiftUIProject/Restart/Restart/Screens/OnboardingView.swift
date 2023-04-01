//
//  OnboardingView.swift
//  Restart
//
//  Created by mac on 01/04/23.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - PROPERTY
    @AppStorage("isOnboarging") var isOnboardingViewIsActive: Bool = true
    @State private var buttionWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttionOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    
    let haptic = UINotificationFeedbackGenerator()
    
    //MARK: - FUNCTION
    
    //MARK: BODY
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                //MARK: - HEADER
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It is not how much we give but
                    how much love we put into giving.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeInOut(duration: 1), value: isAnimating)
                
                //MARK: - CENTER
                ZStack {
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width) / 5)
                        .animation(.easeInOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaleEffect()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(imageOffset.width / 20))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                })
                        )
                        .animation(.easeInOut(duration: 1), value: imageOffset)
                } //: Center
                
                Spacer()
                
                //MARK: - FOOTER
                ZStack {
                    //PARTS OF THE COUSTM BUTTON
                    
                    //1. BACKGRPUNT
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    //2. CALL TO ACTION LABLE
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    //3. CAPSULE
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttionOffset + 80)
                        
                        Spacer()
                    }
                    //4. CIRCLE
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttionOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttionOffset <= buttionWidth - 80 {
                                        buttionOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(Animation.easeInOut(duration: 0.4)) {
                                        if buttionOffset > buttionWidth / 2 {
                                            haptic.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            buttionOffset = buttionWidth - 80
                                            isOnboardingViewIsActive = false
                                        } else {
                                            haptic.notificationOccurred(.warning)
                                            buttionOffset = 0
                                        }
                                    }
                                })
                        )//: GESTURE
                        Spacer()
                    }
                }//: FOOTER
                .frame(width: buttionWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeInOut(duration: 1), value: isAnimating)
            } //: Vstack
        } //: Zstack
        .onAppear {
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

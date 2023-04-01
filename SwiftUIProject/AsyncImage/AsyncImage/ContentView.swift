//
//  ContentView.swift
//  AsyncImage
//
//  Created by mac on 31/03/23.
//

import SwiftUI

extension Image {
    func imageModifire() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifire() -> some View {
        self
            .imageModifire()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    var body: some View {
        //MARK: - BASIC
        //AsyncImage(url: URL(string: "https://credo.academy/credo-academy@3x.png"))
        
        //MARK: - SCALE
        //AsyncImage(url: URL(string: "https://credo.academy/credo-academy@3x.png"), scale: 3.0)
        
        //MARK: - PLACEHOLDER
        //AsyncImage(url: URL(string: "https://credo.academy/credo-academy@3x.png")) { image in
        //    image.imageModifire()
        //} placeholder: {
        //    Image(systemName: "photo.circle.fill").iconModifire()
        //}
        //.padding(40)
        
        //MARK: - PHASE
        //AsyncImage(url: URL(string: "https://credo.academy/credo-academy@3x.png")) { phase in
        //    if let image = phase.image {
        //        image.imageModifire()
        //    } else if phase.error != nil {
        //        Image(systemName: "ant.circle.fill").iconModifire()
        //    } else {
        //        Image(systemName: "photo.circle.fill").iconModifire()
        //    }
        //}
        //.padding(40)
        
        //MARK: - ANIMATION
        AsyncImage(url: URL(string: "https://credo.academy/credo-academy@3x.png"), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image.imageModifire()
                    //.transition(.move(edge: .bottom))
                    //.transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifire()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifire()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  Loading.swift
//  2048
//
//  Created by Alex Luna on 04/08/2020.
//
// inspired by this tutorial https://medium.com/better-programming/
// create-an-awesome-loading-state-using-swiftui-9815ff6abb80

import SwiftUI

struct Loading: View {
    @State private var shouldAnimate = false
    
    @State var willMoveToNextScreen: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient.horizontalLight
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    BlinkingRectangle(shouldAnimate: $shouldAnimate,
                                      color: .darkGray,
                                      number: "2")
                    BlinkingRectangle(shouldAnimate: $shouldAnimate,
                                      color: .specialGray,
                                      number: "0")
                }
                HStack {
                    BlinkingRectangle(shouldAnimate: $shouldAnimate,
                                      color: .shadowGray,
                                      number: "4")
                    BlinkingRectangle(shouldAnimate: $shouldAnimate,
                                      color: .lightGray,
                                      number: "8")
                }
            }
        }
        .onAppear {
            self.shouldAnimate = true
 
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.willMoveToNextScreen = true
                }
            }
        }
    }
}

struct BlinkingRectangle: View {
    @Binding var shouldAnimate: Bool
    var color: Color
    var number: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(width: 80, height: 80)
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(color, lineWidth: 100)
                            .scaleEffect(shouldAnimate ? 1 : 0)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(color, lineWidth: 100)
                            .scaleEffect(shouldAnimate ? 1.5 : 0)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(color, lineWidth: 100)
                            .scaleEffect(shouldAnimate ? 2 : 0)
                    }
                    .opacity(shouldAnimate ? 0.0 : 0.2)
                    .animation(Animation.easeInOut(duration: 1))
                )
            Text(number)
                .fontWeight(.black)
                .font(.system(size: 38))
                .foregroundColor(.offWhite)
                .bold()
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}

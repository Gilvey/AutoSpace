//
//  LounchView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 21.06.24.
//

import SwiftUI

struct LunchView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            AuthView()
        } else {
            VStack{
                VStack{
                    Image(systemName: "car")
                        .font(.system(size: 90))
                        .foregroundColor(.autoblue)
                    Text("AUTOSPACE LLC")
                        .font(.custom("Baskerville-Bold", size: 22))
                }.padding()
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.6)) {
                            self.size = 1.0
                            self.opacity = 1.0
                        }
                    }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    LunchView()
}

//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/24.
//

import Foundation
import SwiftUI



struct FirstSlideView: View {
    var body: some View {
        VStack {

            Image("welcome")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                
            
            Text("Plastics are falling!!")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Text("Slide to Continue")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            
            Spacer()
        
        }
    }
}

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
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            //게임 방법에 대한 설명 쓸 것!
                
            
            Spacer()
        
        }
    }
}

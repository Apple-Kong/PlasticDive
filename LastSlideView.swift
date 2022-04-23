//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import SwiftUI



struct LastSlideView: View {
    var body: some View {
        VStack {
            
            Image("recycling-symbols")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 340)
                
            Text("Ever think about these logos?")
                .font(.title)
                .lineLimit(1)
                .padding(.top, 20)
                
            
            
            Text("they tell you what kind of plastic a product is made from and they are actually the key to becoming a better recycler because all plastics are created equal not everything you put in your blue bin actually gets recycled")
            
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                
            
            Spacer()
            
 
        }
    }
}


struct FirstSlideView: View {
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .lineLimit(1)
                .padding(.top, 20)
            
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 340, height: 200)
                
            
            Text("Plastics are comming!")
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            //게임 방법에 대한 설명 쓸 것!
                
            
            Spacer()
        
        }
    }
}

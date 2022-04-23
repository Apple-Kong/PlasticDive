//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import SwiftUI


struct TrashDescriptionView: View {
    
    var slideInfo: SlideInfo = SlideInfo(title: "Recycle", images: ["trash-1", "trash-2", "trash-5"], description: "types one and two are used in products like water bottles peanut butter jars shampoo bottles, gallon jugs and alot of other things that are parts of our everyday lives")
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Description")
                        .font(.largeTitle)
                        .fontWeight(.bold)
//                    Spacer()
                }
            
                
                HStack(spacing: 20) {
                    
                    ForEach(0..<slideInfo.images.count) { index in
                        Image(slideInfo.images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(.gray)
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
                        
                    }
                  
                    Spacer()
                }
            }
            .padding(.leading, 30)
            .padding(.top, 40)
            
            
            Rectangle()
                .frame(width: 100, height: 150)

            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 100)
                .padding(.bottom, 30)
        }
        .background(.gray.opacity(0.2))
    }
}

struct SecondDescriptionView: View {
    
    var slideInfo: SlideInfo = SlideInfo(title: "Recycle", images: ["trash-2", "trash-5"], description: "types one and two are used in products like water bottles peanut butter jars shampoo bottles, gallon jugs and alot of other things that are parts of our everyday lives")
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Description")
                        .font(.largeTitle)
                        .fontWeight(.bold)
//                    Spacer()
                }
            
                
                HStack(spacing: 20) {
                    
                    ForEach(0..<slideInfo.images.count) { index in
                        Image(slideInfo.images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(.gray)
                            .cornerRadius(10)
                            .frame(width: 100, height: 100)
                        
                    }
                  
                    Spacer()
                }
            
                
                                    
                
                
                
            }
            .padding(.leading, 30)
            .padding(.top, 40)
            
            
            Rectangle()
                .frame(width: 100, height: 150)

            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 200, height: 100)
                .padding(.bottom, 30)
        }
        .background(.gray.opacity(0.2))
    }
}

//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import SwiftUI


struct CongratView: View {
    
    var slideInfo: SlideInfo = SlideInfo(title: "Recycle", images: ["trash-1", "trash-2", "trash-5"], description: "types one and two are used in products like water bottles peanut butter jars shampoo bottles, gallon jugs and alot of other things that are parts of our everyday lives")
    
    var body: some View {
        VStack {
            Text("Great Job!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 30)
                
            
            
            HStack(spacing: 20) {
                
                ForEach(0..<slideInfo.images.count) { index in
                    Image(slideInfo.images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.4), radius: 10)
                        
                }
            }
            
            Spacer()
                .frame(height: 60)
            
            Text(slideInfo.description)
                
            Spacer()
                
        }
        .padding(.horizontal, 30)
    }
}


struct TrashDescriptionView: View {
    
    var slideInfo: SlideInfo = SlideInfo(title: "Recycle", images: ["trash-1", "trash-2", "trash-5"], description: "types one and two are used in products like water bottles peanut butter jars shampoo bottles, gallon jugs and alot of other things that are parts of our everyday lives")
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Description")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                   

                HStack(spacing: 20) {
                    ForEach(0..<slideInfo.images.count) { index in
                        Image(slideInfo.images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .shadow(color: .black.opacity(0.4), radius: 10)
                    }
                }
            }
          
        
            Image("arrow")
                .resizable()
                .aspectRatio(contentMode: .fit)

            
            Image("bluebin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                

            
            Text("Tilt the device and place the plastic in the right place")
                .padding(.horizontal, 60)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
        }
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
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.4), radius: 10)
                        
                    }
                  
                    
                }
            }
            .padding(.leading, 30)
            .padding(.top, 40)
            
            
            Image("arrow")
                .resizable()
                .frame(width: 120, height: 150)

            
            Image("microwave")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
                .padding(.bottom, 30)
        }
    }
}

struct MoreInfoView: View {
    var body: some View {
        
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                HStack {
                    Text("More Information")
                        .font(.title)
                        .fontWeight(.bold)
                    .padding(20)
                    .padding(.top, 20)
                    
                    Spacer()
                }
                    
                
                ItemInfoView(type: .PETE)
                ItemInfoView(type: .HDPE)
                ItemInfoView(type: .PVC)
                ItemInfoView(type: .LDPE)
                ItemInfoView(type: .PS)
                ItemInfoView(type: .PP)
                
            }
            
        }
    }
}

struct ItemInfoView: View {
    
    let type: TrashType
    
    var body: some View {
        VStack {
            HStack {
                Image("\(type.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                Text("\(type.name)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Text("nakefak nfwe nwjkafnwakjfn wakfn wkafwek fwaekfwaef wwa fnewa fwaejkf waeafn af wakjlfnwaek fnlwaf wa fwnajkfnla fnjkawfjkawl ")
                .frame(alignment: .leading)
        }
    }
}

//
//  File.swift
//  WWDC2022
//
//  Created by GOngTAE on 2022/04/23.
//

import SwiftUI


let infos: [SlideInfo] = [
    SlideInfo(title: "Recycle", images: ["trash-1", "trash-2"], description: "Type 1 and Type 2 are easy to recycle. In addtion, Type 5 is expensive to recycle, but it also can be recycled"),
    SlideInfo(title: "Microwave", images: ["trash-2", "trash-5"], description: "Type 2 and Type 5 are very safe to microwave. Type 1 and 4 are highly heat resistant, so it is okay to microwave them, but you should be careful because they can be toxic."),
    
]


struct CongratView: View {
    
    let bluebinAddition: [String] = ["trash-5"]
    let microwaveAddition = ["trash-1", "trash-4"]
    
    var level: Int = 1
    
    init(level: Int) {
        self.level = level
    }
    
    
    var body: some View {
        VStack {
            Text("Great Job!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                
            
            
            HStack(spacing: 20) {
                
                ForEach(0..<infos[level - 1].images.count) { index in
                    Image(infos[level - 1].images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.4), radius: 10)
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            Text(infos[level - 1].description)
            
            
            if level == 1 {
                Image(bluebinAddition[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.4), radius: 10)
    
            } else {
                HStack(spacing: 20) {
                    ForEach(0..<2) { index in
                        Image(microwaveAddition[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .shadow(color: .black.opacity(0.4), radius: 10)
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
}


struct TrashDescriptionView: View {
    
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Description")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                   

                HStack(spacing: 20) {
                    ForEach(0..<2) { index in
                        Image(infos[0].images[index])
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
    
    
    var body: some View {
        
        VStack {
            

            Text("Next Stage...")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            
            
            
            HStack(spacing: 20) {
                ForEach(0..<2) { index in
                    Image(infos[1].images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .shadow(color: .black.opacity(0.4), radius: 10)
                }
            }
            
            Image("arrow")
                .resizable()
                .aspectRatio(contentMode: .fit)
                

            
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
                ItemInfoView(type: .PP)
                ItemInfoView(type: .PS)
                
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
            
            Text(type.description)
                .frame(alignment: .leading)
                .padding(.vertical,10)
        }
    }
}

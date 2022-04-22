import SwiftUI
import SpriteKit
import CoreMotion


// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
struct ContentView: View {
    
    
    var scene: SKScene {
        
        let scene = GameScene()
        //게임 화면의 크기 설정
        //화면에 꽉차게 설정
        scene.scaleMode = .resizeFill //A setting that defines how the scene is mapped to the view that presents it.

        return scene
    }

    var body: some View {
        //스프라이트 뷰를 뷰 계층 구조에 추가~!
        
        ZStack {
            SpriteView(scene: scene)
            TrashDescriptionView()
//            GameOverView()
        }
        .ignoresSafeArea()
    }
}


struct TrashDescriptionView: View {
    
    var body: some View {
        
        VStack {
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("PET")
                        .font(.title)
                        .fontWeight(.bold)
                        
                    Text("#Reusable #useOneTime")
                        .foregroundColor(.gray)
                        
                    
                }
                .frame(height: 100)
                .padding(.leading, 4)
                
                Spacer()
            }
            .padding()
       
            
            Text("PET plastic is easy to recycle. Thus it is accepted at most recycling plants. The plastic items are shredded into tiny pallets and reprocessed into new bottles. Recycled PET bottles can also be turned into polyester fiber. This fabric is applied for producing fleece clothes and carpets or to stuff sleeping bags, jackets, pillows.")
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .padding()
                
            
            Spacer()
            
            HStack {
                Button {
                    print("Home")
                } label: {
                    ZStack {
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                }
                .padding(20)
                
                
                
                Button {
                    print("Home")
                } label: {
                    ZStack {
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                }
                .padding(20)
                

            }
        }
        .frame(width: 400, height: 300)
        .background(.white)
        .cornerRadius(20)
        
        
        
    }
}


struct GameOverView: View {
    
    var score: Int = 0
    
    var body: some View {
        
        VStack {
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
                .padding(.bottom, 20)
            
            Text("Score: 1200")
                .font(.title3)
            
            Spacer()
            
            HStack {
                Button {
                    print("Home")
                } label: {
                    ZStack {
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                }
                .padding(20)
                
                
                
                Button {
                    print("Home")
                } label: {
                    ZStack {
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                }
                .padding(20)
                

            }
        }
        .frame(width: 400, height: 300)
        .background(.white)
        .cornerRadius(20)
        
        
        
    }
}

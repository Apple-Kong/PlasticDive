import SwiftUI
import SpriteKit
import CoreMotion


// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
struct ContentView: View, GUIDelegate {

//    @EnvironmentObject var gameStateManager: GameStateManager
    
    @Binding var isOver: Bool
    
    let gameManager: GameManager?
    
    init(isOver: Binding<Bool>) {
        self._isOver = isOver
        gameManager = GameManager.shared
        gameManager?.delegate = self
    }
   
    
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
                .zIndex(1)
            
            if isOver {
                GameOverView(isOver: $isOver)
                        .frame(width: 300, height: 400)
                        .transition(.scale)
                        .zIndex(2)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
            }
            
//            
//            TabView {
////                FirstSlideView()
//                
////                FirstSlideView()
//                SecondDescriptionView()
//                TrashDescriptionView()
//                    
//            }
//            .tabViewStyle(.page)
//            .background(.gray)
//            .cornerRadius(20)
//            .frame(width: 400, height: 450)
//            .transition(.scale)
//            .zIndex(2)
//            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
            
            
        }
        .ignoresSafeArea()

    }
    
    //MARK: - Delegate
    
    func nextLevel() {
        print("DEBUG: nextLevel")
    }
    
    func gameOver() {
        withAnimation {
//            self.gameStateManager.state = .over
            self.isOver = true
        }
        print("DEBUG: gameOver delegates \(isOver)")
    }
}




struct SlideInfo {
    let title: String
    let images: [String]
    let description: String
}






struct GameOverView: View {
    
    var score: Int = 0
    
    @Binding var isOver: Bool
    
    let gameManager = GameManager.shared
    
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
                    
                    withAnimation {
                        isOver = false
                    }
                    
                    gameManager.startGame()
                    
                    
                    
                } label: {
                    ZStack {
                        Text("Try again")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
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

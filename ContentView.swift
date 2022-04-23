import SwiftUI
import SpriteKit
import CoreMotion


// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points
struct ContentView: View, UIDelegate {

//    @EnvironmentObject var gameStateManager: GameStateManager
    
    @Binding var isOver: Bool
    @State var isStartViewShown: Bool = true
    @Binding var isGoingToNextLevel: Bool
    
    let gameManager: GameManager?
    
    init(isOver: Binding<Bool>, isGoing: Binding<Bool>) {
        self._isOver = isOver
        self._isGoingToNextLevel = isGoing
      
        gameManager = GameManager.shared
        gameManager?.uiDelegate = self
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
            
            
            if isStartViewShown {
                TabView {
    //                FirstSlideView()
                    
//                    MoreInfoView()
                    
                    FirstSlideView()
                        .foregroundColor(.black)
                    
                    TrashDescriptionView()
                    
                    GameStartButtonView(isShown: $isStartViewShown)

                }
                .tabViewStyle(.page)
                .background(.white)
                .cornerRadius(20)
                .frame(width: 400, height: 450)
                .transition(.scale)
                .zIndex(2)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
            }

            
            
            if isGoingToNextLevel {
                TabView {

                    CongratView()
                        .foregroundColor(.black)
                    
                    SecondDescriptionView()
                    
                    GameStartButtonView(isShown: $isGoingToNextLevel)

                }
                .tabViewStyle(.page)
                .background(.white)
                .cornerRadius(20)
                .frame(width: 400, height: 450)
                .transition(.scale)
                .zIndex(2)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
            }
            

            
            if isOver {
                
                TabView {
                    
                    ForEach(messages) { item in
                        LastTextView(text: item.text)
                            .padding(20)
                    }

                    LastSlideView()
                        .foregroundColor(.black)
                        .padding(20)
                    
                    MoreInfoView()
                        .foregroundColor(.black)
                        .padding(20)
                    
                    GameOverView(isOver: $isOver)
                            .zIndex(2)
                        

                }
                .tabViewStyle(.page)
                .background(.white)
                .cornerRadius(20)
                .frame(width: 500, height: 600)
                .transition(.scale)
                .zIndex(2)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
                .transition(.scale)
               
            }
        }
        .ignoresSafeArea()
    }
    
    //MARK: - Delegate
    
    func nextLevel(level: Int) {
        print("DEBUG: nextLevel \(level)")
        
        if level == 2 {
            self.isGoingToNextLevel = true
        }
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



struct GameStartButtonView: View {
    
    let gameManager = GameManager.shared
    
    @Binding var isShown: Bool
    
    var body: some View {
        
        VStack {
            Button {
                print("DEBUG: Start Game")
                isShown = false
                gameManager.startGame()
                    
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 300, height: 70)
                    
                    Text("Game Start")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct Message: Identifiable {
    var id: Int
    let text: String
    
}

let messages: [Message] = [
    Message(id: 0, text: "Did you enjoy the game?"),
    Message(id: 1, text: "You have now learned which plastics are well recycled. So you can make more environmentally friendly choices when you buy plastic products."),
    Message(id: 2, text: "In addition, you know which plastic you shouldn't put in the microwave. So now, You're able to protect your health"),
    Message(id: 3, text: "The numbers on these cute friends' bodies are actually..."),
    Message(id: 4, text: "Indicates the ISO specification plastic type.")
]


struct LastTextView: View {
    let text: String
    
    
    var body: some View {
        VStack {
            Text(text)
                .font(.title3)
                .multilineTextAlignment(.center)
        }
    }
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
            
            Text("Score: \(gameManager.score)")
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
                    print("Try Again")
                    
                    withAnimation {
                        isOver = false
                    }
                    gameManager.resetGame()
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

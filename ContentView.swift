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
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}






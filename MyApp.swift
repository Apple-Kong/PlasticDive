import SwiftUI

@main
struct MyApp: App {
    
    @State private var isOver = false
//    @StateObject private var gameStateManager = GameStateManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(isOver: $isOver)
//                .environmentObject(gameStateManager)
        }
    }
}

class GameStateManager: ObservableObject {
    @Published var state: GameState = GameState.home
}

enum GameState {
    case home
    case playing
    case pause
    case over
    case moveToNextLevel
}

import SwiftUI

@main
struct MyApp: App {
    @State private var isOver = false
    @State private var goingToNextLevel = false
    
    var body: some Scene {
        WindowGroup {
            ContentView(isOver: $isOver, isGoing: $goingToNextLevel)

        }
    }
}

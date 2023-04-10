import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                SushiView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

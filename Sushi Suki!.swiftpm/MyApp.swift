import SwiftUI

@main
struct MyApp: App {
    @StateObject private var sushiDB = SushiDB()
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationView()
                    .environmentObject(sushiDB)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

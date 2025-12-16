import SwiftUI

@main
struct BananaJungleApp: App {
    
    init() {
        let stats = UserDefaultsManager.shared
        let key = "didAddInitialCoins"
        if !UserDefaults.standard.bool(forKey: key) {
            stats.addCoins(5000)
            UserDefaults.standard.set(true, forKey: "isMusicOn")
            UserDefaults.standard.set(true, forKey: key)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}

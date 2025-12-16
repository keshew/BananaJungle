import SwiftUI

class BananaSettingsViewModel: ObservableObject {
    let contact = BananaSettingsModel()
    @ObservedObject private var soundManager = SoundManager.shared
    
    @Published var isSoundOn: Bool {
        didSet {
            UserDefaults.standard.set(isSoundOn, forKey: "isMusicOn")
            soundManager.toggleMusic()
            NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
        }
    }
    
    @Published var isNotification: Bool {
        didSet {
            UserDefaults.standard.set(isNotification, forKey: "isNotification")
            NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
        }
    }
    
    @Published var isVib: Bool {
        didSet {
            UserDefaults.standard.set(isVib, forKey: "isVib")
            NotificationCenter.default.post(name: Notification.Name("UserResourcesUpdated"), object: nil)
        }
    }
    
    init() {
        self.isSoundOn = UserDefaults.standard.bool(forKey: "isMusicOn")
        self.isNotification = UserDefaults.standard.bool(forKey: "isNotification")
        self.isVib = UserDefaults.standard.bool(forKey: "isVib")
    }
}

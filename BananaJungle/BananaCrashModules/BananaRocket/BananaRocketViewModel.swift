import SwiftUI

class BananaRocketViewModel: ObservableObject {
    let contact = BananaRocketModel()
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet: Int = 50
    
    @Published var isFlying = false
    @Published var multiplier: Double = 1.00
    @Published var gameResult: GameResult = .none
    @Published var showResult = false
    
    @Published var isShaking = false
    @Published var currentImageName = "banana"
    
    @Published var shakeRotation: Double = 0
    @Published var shakeOffsetX: CGFloat = 0
    @Published var shakeOffsetY: CGFloat = 0
    
    private var timer: Timer?
    private var crashMultiplier: Double = 0
    
    enum GameResult {
        case none, win, lose
    }
    
    func startGame() {
        currentImageName = "banana"
        isFlying = true
        isShaking = true
        showResult = false
        multiplier = 1.0
        gameResult = .none
        
        crashMultiplier = Double.random(in: 1.5...4.5)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.updateMultiplier()
        }
    }
    
    func withdraw() {
        timer?.invalidate()
        isFlying = false
        isShaking = false
        shakeRotation = 0
        shakeOffsetX = 0
        shakeOffsetY = 0
        multiplier = max(1.2, multiplier)
        gameResult = .win
        showResult = true
        updateCoins(true)
    }
    
    private func updateMultiplier() {
        multiplier += 0.08
        
        if isShaking {
            shakeRotation = Double.random(in: -2...2)
            shakeOffsetX = CGFloat.random(in: -5...5)
            shakeOffsetY = CGFloat.random(in: -2...2)
        }
        
        if multiplier >= crashMultiplier {
            timer?.invalidate()
            isFlying = false
            isShaking = false
            shakeRotation = 0
            shakeOffsetX = 0
            shakeOffsetY = 0
            currentImageName = "bananaLose"
            gameResult = .lose
            showResult = true
            updateCoins(false)
        }
    }
    
    private func updateCoins(_ won: Bool) {
        let payout = Int(Double(bet) * multiplier)
        if won {
            coin += payout - bet
            UserDefaultsManager.shared.recordWin(payout)
        } else {
            coin -= bet
            UserDefaultsManager.shared.recordLoss(bet)
        }
        UserDefaultsManager.shared.coins = coin
    }
}

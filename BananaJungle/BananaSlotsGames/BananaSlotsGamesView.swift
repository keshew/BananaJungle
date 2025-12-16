import SwiftUI

struct BananaSlotsGamesView: View {
    @StateObject var bananaSlotsGamesModel =  BananaSlotsGamesViewModel()
    @State var showAlert = false
    @State var slot1 = false
    @State var slot2 = false
    @State var slot3 = false
    @State var coin = UserDefaultsManager.shared.coins
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color(red: 23/255, green: 32/255, blue: 54/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        soundManager.toggleMusic()
                    }) {
                        Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(Color(red: 113/255, green: 123/255, blue: 160/255))
                    }
                    
                    Spacer()
                    
                    Text("Game Name")
                        .font(.custom("Gantari-Medium", size: 22))
                        .foregroundStyle(Color(red: 113/255, green: 123/255, blue: 160/255))
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 253/255, green: 169/255, blue: 48/255), .clear,.clear,.clear], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 118/255, green: 124/255, blue: 154/255))
                                .overlay {
                                    HStack(spacing: 5) {
                                        Image("coin")
                                            .resizable()
                                            .frame(width: 26, height: 26)
                                        
                                        Text("\(coin)")
                                            .font(.custom("Gantari-Bold", size: 15))
                                            .foregroundStyle(.white)
                                    }
                                    .offset(x: -5)
                                }
                        }
                        .frame(width: 79, height: 41)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Text("Slots Games")
                            .font(.custom("Gantari-Bold", size: 33))
                            .foregroundStyle(Color(red: 21/255, green: 137/255, blue: 254/255))
                        
                        
                        ForEach(0..<9, id: \.self) { index in
                            Button(action: {
                                if index <= 2 {
                                    switch index {
                                    case 0: slot1 = true
                                    case 1: slot2 = true
                                    case 2: slot3 = true
                                    default:
                                        slot1 = true
                                    }
                                } else {
                                    showAlert = true
                                }
                            }) {
                                Image("slot\(index + 1)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .background(Color(red: 27/255, green: 40/255, blue: 74/255))
                                    .cornerRadius(35)
                                    .frame(width: 350, height: 220)
                            }
                            .alert("This game will be open soon!", isPresented: $showAlert) {
                                Button("OK") {}
                            }
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                coin = UserDefaultsManager.shared.coins
            }
        }
        .fullScreenCover(isPresented: $slot1) {
            FortuneJungleView()
        }
        .fullScreenCover(isPresented: $slot2) {
            ZombieJackpotView()
        }
        .fullScreenCover(isPresented: $slot3) {
            CyberSpinView()
        }
    }
}

#Preview {
    BananaSlotsGamesView()
}


import SwiftUI

struct BananaMenuView: View {
    @StateObject var bananaMenuModel =  BananaMenuViewModel()
    @Binding var selectedTab: CustomTabBar.TabType
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
                    VStack(spacing: 50) {
                        Button(action: {
                            selectedTab = .Slots
                        }) {
                            Image("slots")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 220)
                        }
                        
                        Button(action: {
                            selectedTab = .Crash
                        }) {
                            Image("crash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 220)
                        }
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
    }
}

#Preview {
    BananaMenuView(selectedTab: .constant(.Menu))
}


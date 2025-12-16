import SwiftUI

struct BananaRocketView: View {
    @StateObject var viewModel =  BananaRocketViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack() {
            ZStack(alignment: .top) {
                Image("bananaRocketBg")
                    .resizable()
                
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 9/255, green: 100/255, blue: 30/255), .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 120)
            }
            .ignoresSafeArea()
            
            Image(viewModel.currentImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width > 700 ? 300 : 250, height: 300)
                .ignoresSafeArea()
                .rotationEffect(.degrees(viewModel.shakeRotation))
                .scaleEffect(viewModel.isShaking ? 1.02 : 1.0)
                .offset(x: viewModel.shakeOffsetX, y: viewModel.shakeOffsetY)
                .animation(.easeInOut(duration: 0.08), value: viewModel.shakeRotation) 
                .animation(.easeInOut(duration: 0.08), value: viewModel.shakeOffsetX)
                .animation(.easeInOut(duration: 0.08), value: viewModel.shakeOffsetY)


            
            VStack {
                HStack(spacing: 35) {
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("backWhit")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        soundManager.toggleMusic()
                    }) {
                        Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                            .font(.custom("Gantari-Medium", size: 34))
                            .foregroundStyle(.white)
                            .frame(width: 34, height: 34)
                    }
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 253/255, green: 169/255, blue: 48/255), .black.opacity(0.3), .black.opacity(0.3) , .black.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(red: 113/255, green: 123/255, blue: 160/255))
                                .overlay {
                                    HStack(spacing: 5) {
                                        Image("coin")
                                            .resizable()
                                            .frame(width: 26, height: 26)
                                        
                                        Text("\(viewModel.coin)")
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
                .padding(.top, UIScreen.main.bounds.width > 700 ? 50 : 5)
                
                Text("x \(viewModel.multiplier, specifier: "%.2f")")
                    .font(.custom("Gantari-Bold", size: 62))
                    .foregroundStyle(Color(red: 255/255, green: 199/255, blue: 34/255))
                    .padding(.top)
                
                if viewModel.showResult {
                    Text(viewModel.gameResult == .win ? "YOU WIN!" : "YOU LOSE!")
                        .font(.custom("Gantari-Bold", size: 48))
                        .foregroundStyle(Color(red: 255/255, green: 199/255, blue: 34/255))
                        .padding()
                        .cornerRadius(20)
                        .scaleEffect(1.2)
                        .animation(.easeInOut(duration: 0.5).repeatCount(3), value: viewModel.showResult)
                }
                
                Spacer()
                
                VStack(spacing: 23) {
                    HStack(spacing: 20) {
                        Rectangle()
                            .fill(.black.opacity(0.6))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LinearGradient(colors: [Color(red: 242/255, green: 103/255, blue: 0/255),
                                                                    Color(red: 254/255, green: 237/255, blue: 35/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 0)
                                    .overlay {
                                        HStack(alignment: .bottom, spacing: 10) {
                                            Button(action: {
                                                if viewModel.bet >= 100 {
                                                    viewModel.bet -= 50
                                                }
                                            }) {
                                                Text("-")
                                                    .font(.custom("Gantari-Medium", size: 32))
                                                    .foregroundStyle(Color(red: 255/255, green: 194/255, blue: 39/255))
                                                    .offset(y: 5)
                                            }
                                            
                                            VStack(spacing: 15) {
                                                Text("Select Bet")
                                                    .foregroundStyle(Color(red: 255/255, green: 194/255, blue: 39/255))
                                                    .font(.custom("Gantari-Medium", size: 14))
                                                
                                                Rectangle()
                                                    .fill(.white)
                                                    .overlay {
                                                        Text("\(viewModel.bet)")
                                                            .foregroundStyle(.black)
                                                            .font(.custom("Gantari-Medium", size: 22))
                                                            .offset(y: 1)
                                                    }
                                                    .frame(width: 80, height: 25)
                                                    .cornerRadius(20)
                                            }
                                            
                                            Button(action: {
                                                if (viewModel.bet + 50) <= viewModel.coin {
                                                    viewModel.bet += 50
                                                }
                                            }) {
                                                Text("+")
                                                    .font(.custom("Gantari-Medium", size: 32))
                                                    .foregroundStyle(Color(red: 255/255, green: 194/255, blue: 39/255))
                                                    .offset(y: 5)
                                            }
                                        }
                                    }
                            }
                            .frame(width: 220, height: 90)
                            .cornerRadius(20)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                        
                        Button(action: {
                            if viewModel.isFlying {
                                viewModel.withdraw()
                            } else {
                                if viewModel.bet <= viewModel.coin {
                                    viewModel.startGame()
                                }
                            }
                        }) {
                            Rectangle()
                                .fill(.black.opacity(0.6))
                                .overlay {
                                    Text(viewModel.isFlying ? "Withdraw" : "Bet")
                                        .font(.custom("Gantari-Medium", size: viewModel.isFlying ? 18 : 28))
                                        .foregroundStyle(Color(red: 255/255, green: 194/255, blue: 39/255))
                                }
                                .frame(width: 120, height: 60)
                                .cornerRadius(20)
                                .shadow(color: .white.opacity(0.5), radius: 5)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    BananaRocketView()
}


import SwiftUI

struct BananaHelicopterView: View {
    @StateObject var viewModel =  BananaHelicopterViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack() {
            ZStack(alignment: .top) {
                Image("helicoptBg")
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
            
            if viewModel.showResult {
                Image(viewModel.gameResult == .win ? "winHelic" : "loseLabelHeli")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .offset(y: viewModel.gameResult == .lose ? -100 : 0)
            }
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
                    .foregroundStyle(LinearGradient(colors: [Color(red: 251/255, green: 255/255, blue: 1/255),
                                                             Color(red: 255/255, green: 0/255, blue: 183/255)], startPoint: .leading, endPoint: .trailing))
                    .padding(.top)
                
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
                                    Text(viewModel.isFlying ? "WITHDRAW" : "BET")
                                        .font(.custom("Gantari-Bold", size: viewModel.isFlying ? 18 : 28))
                                        .foregroundStyle(LinearGradient(colors: [Color(red: 251/255, green: 255/255, blue: 1/255),
                                                                                 Color(red: 255/255, green: 0/255, blue: 183/255)], startPoint: .leading, endPoint: .trailing))
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
    BananaHelicopterView()
}


import SwiftUI

struct CyberSpinView: View {
    @StateObject var viewModel =  CyberSpinViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image("cyberBg")
                .resizable()
                .ignoresSafeArea()
            
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
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 23) {
                        ZStack(alignment: .bottom) {
                            Image("cyber")
                                .resizable()
                                .frame(width: 136, height: 152)
                            
                            Rectangle()
                                .fill(Color(red: 58/255, green: 6/255, blue: 54/255).opacity(0.6))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, lineWidth: 0)
                                        .overlay {
                                            Text("WIN: \(viewModel.win)")
                                                .font(.custom("Gantari-Bold", size: 42))
                                                .foregroundStyle(Color(red: 189/255, green: 54/255, blue: 8/255))
                                                .offset(y: 2)
                                        }
                                }
                                .frame(width: 250, height: 70)
                                .cornerRadius(12)
                                .padding(.top, UIScreen.main.bounds.width > 700 ? 50 : 35)
                        }
                        
                        Rectangle()
                            .fill(Color(red: 58/255, green: 6/255, blue: 54/255).opacity(0.6))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 0)
                                    .overlay {
                                        VStack(spacing: 15) {
                                            ForEach(0..<3, id: \.self) { row in
                                                HStack(spacing: 10) {
                                                    ForEach(0..<5, id: \.self) { col in
                                                        Image(viewModel.slots[row][col])
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 45, height: 35)
                                                            .padding(.horizontal, 5)
                                                            .padding(.vertical, 8)
                                                            .background(viewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color(red: 58/255, green: 6/255, blue: 54/255) : Color.black.opacity(0.3))
                                                            .cornerRadius(10)
                                                    }
                                                }
                                            }
                                        }
                                    }
                            }
                            .frame(width: 350, height: 220)
                            .cornerRadius(20)
                        
                        Rectangle()
                            .fill(Color(red: 58/255, green: 6/255, blue: 54/255).opacity(0.6))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LinearGradient(colors: [Color(red: 242/255, green: 103/255, blue: 0/255),
                                                                    Color(red: 254/255, green: 237/255, blue: 35/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 0)
                                    .overlay {
                                        HStack(alignment: .bottom, spacing: 20) {
                                            Button(action: {
                                                if viewModel.bet >= 100 {
                                                    viewModel.bet -= 50
                                                }
                                            }) {
                                                Text("-")
                                                    .font(.custom("Gantari-Medium", size: 42))
                                                    .foregroundStyle(Color(red: 189/255, green: 54/255, blue: 8/255))
                                            }
                                            
                                            VStack(spacing: 5) {
                                                Text("Select Bet")
                                                    .foregroundStyle(Color(red: 189/255, green: 54/255, blue: 8/255))
                                                    .font(.custom("Gantari-Medium", size: 20))
                                                
                                                Rectangle()
                                                    .fill(.white)
                                                    .overlay {
                                                        Text("\(viewModel.bet)")
                                                            .foregroundStyle(.black)
                                                            .font(.custom("Gantari-Medium", size: 22))
                                                            .offset(y: 1)
                                                    }
                                                    .frame(width: 190, height: 35)
                                                    .cornerRadius(20)
                                            }
                                            
                                            Button(action: {
                                                if (viewModel.bet + 50) <= viewModel.coin {
                                                    viewModel.bet += 50
                                                }
                                            }) {
                                                Text("+")
                                                    .font(.custom("Gantari-Medium", size: 42))
                                                    .foregroundStyle(Color(red: 189/255, green: 54/255, blue: 8/255))
                                            }
                                        }
                                    }
                            }
                            .frame(width: 350, height: 100)
                            .cornerRadius(20)
                        
                        Button(action: {
                            if viewModel.coin >= viewModel.bet {
                                viewModel.spin()
                            }
                        }) {
                            Image("spinCyber")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140, height: 90)
                        }
                        .disabled(viewModel.isSpinning)
                    }
                  
                }
            }
            
            if viewModel.win >= 2000 {
                Image("cyberBg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Image("cyber")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 236, height: 252)
                            .offset(x: 70, y: -150)
                        
                        Image("winCyber")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    }
                    
                    Rectangle()
                        .fill(Color(red: 189/255, green: 54/255, blue: 8/255).opacity(0.3))
                        .frame(width: 300, height: 80)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(LinearGradient(colors: [Color(red: 242/255, green: 103/255, blue: 0/255),
                                                                Color(red: 254/255, green: 237/255, blue: 35/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 0)
                                .overlay {
                                    Text("WIN: \(viewModel.win)")
                                        .font(.custom("Gantari-Bold", size: 32))
                                        .foregroundStyle(LinearGradient(colors: [Color(red: 20/255, green: 124/255, blue: 255/255),
                                                                                 Color(red: 223/255, green: 20/255, blue: 226/255)], startPoint: .leading, endPoint: .trailing))
                                        .offset(y: 5)
                                }
                        }
                        .cornerRadius(20)
                        
                    Button(action: {
                        viewModel.win = 0
                    }) {
                        Rectangle()
                            .fill(Color(red: 189/255, green: 54/255, blue: 8/255).opacity(0.3))
                            .frame(width: 200, height: 40)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(LinearGradient(colors: [Color(red: 242/255, green: 103/255, blue: 0/255),
                                                                    Color(red: 254/255, green: 237/255, blue: 35/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 0)
                                Text("Next")
                                    .font(.custom("Gantari-Medium", size: 22))
                                    .foregroundStyle(LinearGradient(colors: [Color(red: 20/255, green: 124/255, blue: 255/255),
                                                                             Color(red: 223/255, green: 20/255, blue: 226/255)], startPoint: .leading, endPoint: .trailing))
                                    .offset(y: 1)
                            }
                            .cornerRadius(20)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    CyberSpinView()
}


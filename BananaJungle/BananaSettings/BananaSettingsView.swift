import SwiftUI

struct BananaSettingsView: View {
    @StateObject var settingsModel =  BananaSettingsViewModel()
    @State var coin = UserDefaultsManager.shared.coins
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color(red: 23/255, green: 32/255, blue: 54/255).ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Settings")
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
                        
                        VStack(spacing: 23) {
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("set1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Text("Notifications ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(Color(red: 241/255, green: 229/255, blue: 236/255))
                                                
                                                Toggle("", isOn: $settingsModel.isNotification)
                                                    .toggleStyle(CustomToggleStyle())
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 91)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("set2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Text("Sound effect ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(Color(red: 241/255, green: 229/255, blue: 236/255))
                                                
                                                Toggle("", isOn: $settingsModel.isSoundOn)
                                                    .toggleStyle(CustomToggleStyle())
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 91)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("set3")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .trailing, spacing: 5) {
                                                Text("Vibration        ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(Color(red: 241/255, green: 229/255, blue: 236/255))
                                                
                                                Toggle("", isOn: $settingsModel.isVib)
                                                    .toggleStyle(CustomToggleStyle())
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 91)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("set4")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Technical        \nSupport  ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(Color(red: 241/255, green: 229/255, blue: 236/255))
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 91)
                                .cornerRadius(15)
                        }
                        .padding(.horizontal, 30)
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
    BananaSettingsView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 224/255, green: 131/255, blue: 21/255) : Color(red: 121/255, green: 121/255, blue: 121/255))
                .frame(width: 42, height: 22)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}


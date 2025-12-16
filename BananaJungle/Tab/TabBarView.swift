import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBar.TabType = .Menu
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Menu {
                    BananaMenuView(selectedTab: $selectedTab)
                } else if selectedTab == .Slots {
                    BananaSlotsGamesView()
                } else if selectedTab == .Crash {
                    BananaCrashGamesView()
                } else if selectedTab == .Profile {
                    BananaProfileView()
                } else if selectedTab == .Settings {
                    BananaSettingsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Menu
        case Slots
        case Crash
        case Profile
        case Settings
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color(red: 42/255, green: 52/255, blue: 100/255))
                    .frame(height: 110)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .offset(y: 35)
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Menu, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Slots, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Crash, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Profile, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .Settings, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            if tab == selectedTab {
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 225/255, green: 106/255, blue: 184/255),
                                                  Color(red: 221/255, green: 64/255, blue: 135/255)], startPoint: .top, endPoint: .bottom))
                    .overlay {
                        VStack(spacing: -10) {
                            Image(selectedTab == tab ? imageName + "Picked" : imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 52, height: 52)
                                .scaleEffect(tab == CustomTabBar.TabType.Crash ? 0.45 : 1)
                            
                            Text("\(tab)")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                        .offset(y: -5)
                    }
                    .frame(width: 65, height: 65)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .shadow(color: Color(red: 221/255, green: 64/255, blue: 135/255), radius: 5)
            } else {
                VStack(spacing: -10) {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 52, height: 52)
                        .scaleEffect(tab == CustomTabBar.TabType.Crash ? 0.45 : 1)
                    
                    Text("\(tab)")
                        .font(.system(size: 16))
                        .foregroundStyle(Color(red: 113/255, green: 123/255, blue: 160/255))
                }
                .frame(maxWidth: .infinity)
                .offset(y: -5)
            }
        }
    }
}

import SwiftUI

struct BananaProfileView: View {
    @StateObject var bananaProfileModel =  BananaProfileViewModel()
    @State var coin = UserDefaultsManager.shared.coins
    @ObservedObject private var soundManager = SoundManager.shared
    @State private var profileImageData: Data?
    @State private var showingImagePicker = false
    
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
                    
                    Text("Profile")
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
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            ZStack(alignment: .bottomTrailing) {
                                Group {
                                    if let data = UserDefaultsManager.shared.profileImageData ?? profileImageData,
                                       let uiImage = UIImage(data: data) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    } else {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 255/255, green: 150/255, blue: 82/255),
                                                                          Color(red: 48/255, green: 59/255, blue: 109/255)], startPoint: .bottomLeading, endPoint: .topTrailing))
                                            .overlay {
                                                VStack {
                                                    Image("addImg")
                                                        .resizable()
                                                        .frame(width: 80, height: 80)
                                                }
                                            }
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(20)
                                    }
                                }
                                Image("plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(15)
                            }
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            PhotoPicker(imageData: $profileImageData)
                                .ignoresSafeArea()
                        }
                        .onChange(of: profileImageData) { newData in
                            if let data = newData {
                                UserDefaultsManager.shared.profileImageData = data
                            }
                        }
                        
                        VStack(spacing: 23) {
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("pr1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Balance           ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(.white)
                                                
                                                Text("\(UserDefaultsManager.shared.coins)")
                                                    .font(.custom("Gantari-Regular", size: 15))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 70)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("pr2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Total Wins      ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(.white)
                                                
                                                Text("\(UserDefaultsManager.shared.totalWins)")
                                                    .font(.custom("Gantari-Regular", size: 15))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 70)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("pr3")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Win Rate        ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(.white)
                                                
                                                Text("\(String(format: "%.1f", UserDefaultsManager.shared.winRate))%")
                                                    .font(.custom("Gantari-Regular", size: 15))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 70)
                                .cornerRadius(15)
                            
                            Rectangle()
                                .fill(Color(red: 37/255, green: 61/255, blue: 125/255))
                                .overlay {
                                    ZStack(alignment: .leading) {
                                        Image("pr4")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        HStack {
                                            Spacer()
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text("Biggest Win ")
                                                    .font(.custom("Gantari-Bold", size: 22))
                                                    .foregroundStyle(.white)
                                                
                                                Text("\(UserDefaultsManager.shared.maxWinAmount)")
                                                    .font(.custom("Gantari-Regular", size: 15))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(height: 70)
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
    BananaProfileView()
}

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var imageData: Data?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let item = results.first else { return }
            
            item.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage,
                          let data = image.jpegData(compressionQuality: 0.8) else { return }
                    self.parent.imageData = data
                }
            }
        }
    }
}

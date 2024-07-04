//
//  TestView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 28.06.24.
//

import SwiftUI
import PhotosUI

struct TestView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var image: UIImage?
    var body: some View {
        ZStack{
            Image(uiImage: image ?? UIImage(resource: .profile))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(24)
                
            
            
            PhotosPicker(selection: $selectedItem, matching: .images) {
                ZStack{
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.pink)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 3)
                        )
                    
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                }
            }.offset(x: 24, y:24)
                .onChange(of: selectedItem) { _, _ in
                    Task {
                        if let selectedItem,
                           let data = try? await selectedItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                self.image = image
                                UserDefaults.standard.set(data, forKey: "profilePhoto")
                                print("фото загружено")
                            }
                        }
                        selectedItem = nil
                    }
                }
            
        }.onAppear{
            if let imageData = UserDefaults.standard.data(forKey: "profilePhoto") {
                image = UIImage(data: imageData)
            }
        }
        
       
    }
}

#Preview {
    TestView()
}

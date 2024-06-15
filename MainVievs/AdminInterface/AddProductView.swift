//
//  SwiftUIView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 11.05.24.
//

import SwiftUI

struct AddProductView: View {
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "bg")!
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var price: Int? = nil
    @State private var isRecommended = false
    @Environment (\.dismiss) var dismiss


    
    var body: some View {
        VStack {
            Text("Добавить товар")
                .font(.title2)
                .bold()
            VStack {
                
                
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 300)
                    .cornerRadius(22)
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
                
                TextField("Название продукта", text: $title)
                TextField("Цена продукта", value: $price, format: .number)
                    .keyboardType(.numberPad)
                TextField("Описание продукта", text: $description)
                Text("Популярный товар?")
                    .padding(.vertical, 3)
                Picker("Популярный товар?", selection: $isRecommended) {
                    Text("Да").tag(true)
                    Text("Нет").tag(false)
                }.pickerStyle(.segmented)
                    
            }.padding(8)
                .background(Color.alpha1)
                .cornerRadius(25)
            
            
            Button {
                
                
                guard let price = price else { 
                    print("Невозможно извлечь цену")
                    return
                }
                let product = Product(id: UUID().uuidString, title: title, price: price, discription: description, isRecommended: isRecommended)
                guard let imageData = image.jpegData(compressionQuality: 0.11) else { return }
                
                DataBaseService.shared.setProduct(product: product, image: imageData) { result in
                    switch result {
                        
                    case .success(let product):
                        print(product.title)
                     dismiss()
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                    }
                }
                
            } label: {
                Text("Сохранить")
                .font(.title3)
                .padding()
                .frame(maxWidth: 170)
                .background(Color("autoblue"))
                .cornerRadius(24)
                .foregroundColor(.white)
            }.padding()
            
            Spacer()
            
            
        }.padding(.horizontal, 15)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourseType: .photoLibrary, selectedImage: $image)
        })
    }
}

#Preview {
    AddProductView()
}

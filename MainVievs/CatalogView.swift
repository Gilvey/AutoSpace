//
//  CatalogView.swift
//  AutoSpace
//
//  Created by Николай Гильвей on 17.04.24.
//

import SwiftUI

struct CatalogView: View {
    
    let layout = GridItem(.adaptive(minimum: screen.width / 2.2))
    
    @StateObject var viewModel = CatalogViewModel()
    
    var body: some View {
        
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                Section("Популярное") {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [layout], spacing: 12) {
                            ForEach(viewModel.carParts.filter {
                                $0.isRecommended
                            }, id: \.id) { item in
                                NavigationLink {
                                    
                                    let viewModel = ProductDetailVeiwModel(product: item)
                                    
                                    ProductDetailView(viewModel: viewModel)
                                } label: {
                                    ProductCell(product: item)
                                        .foregroundColor(.black)
                                }
                            }
                        }.padding(8)
                    }
                    
                    
                }
                
                
                Section("Основные") {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [layout], spacing: 12) {
                            ForEach(viewModel.carParts, id: \.id) { item in
                                NavigationLink {
                                    
                                    let viewModel = ProductDetailVeiwModel(product: item)
                                    ProductDetailView(viewModel: viewModel)                                } label: {
                                        ProductCell(product: item)
                                            .foregroundColor(.black)
                                    }
                                
                            }
                        }.padding(8)
                    }
                    
                    
                }
//                .onAppear { print("get product")
//                    self.viewModel.getProducts()
//                    }
                
            }
        }.onAppear { print("get product")
            self.viewModel.getProducts()
            }
    }
}

#Preview {
    CatalogView()
}

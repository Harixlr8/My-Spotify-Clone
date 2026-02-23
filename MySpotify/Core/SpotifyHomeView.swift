//
//  SpotifyHomeView.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    @State private var currentUser : User? = nil
    @State private var selectedCategory : Category? = nil
    @State var products : [Product] = []
    @State var productRows : [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack
                .ignoresSafeArea()
            ScrollView {

                LazyVStack( spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                recentSection
                            .padding()
                        if let product = products.first {
                            newReleaseSeciton(product: product)
                               
                        }
                    listRows
                       
                    } header: {
                        header
                    }

                }
            }
            
            .clipped()
        }
        .task {
            await fetchData()
        }
    }
    func fetchData() async  {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows : [ProductRow] = []
            let allTitle = Set(products.map({ $0.title }))
            for title in allTitle {
//                let products = self.products.filter({ $0.title == title})
                rows.append(ProductRow(title: title, products: products))
            }
            productRows = rows
        } catch  {
             print(error)
        }
    }
}
extension SpotifyHomeView {
    private var header : some View {
        HStack{
            VStack {
                if let user = currentUser {
                    ImageLoaderView(urlString: user.image)
                        .frame(width: 35,height: 35)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(minWidth: 40)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Category.allCases,id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized,
                                     isSelected: category == selectedCategory
                        ).onTapGesture {
                            selectedCategory = category
                            
                        }
                    }
                    
                }
            }.scrollIndicators(.hidden)
            
        }
        .padding(.vertical , 24)
        .padding(.leading )
        .padding(.bottom , 10)
        .background(Color.spotifyBlack)
    }
    private var recentSection : some View {
        NonLazyVGrid(columns: 2,
                     alignment: .center,
                     spacing: 10,
                     items: products) { product in
            if let product {
                RecentCell(imageString: product.firstImage , title: product.title)
                    .asButton(.press) {
                        showRecentPlaylist(product: product)
                    }
            }
            
        }
    }
    private func newReleaseSeciton(product : Product) -> some View {
        
            return NewReleaseCell(
                imageName: product.firstImage,
                headline: product.title,
                subheadline: product.category.capitalized,
                title: product.title,
                subtitle: "\(product.rating)" ){
                    showRecentPlaylist(product: product)
                } addToPlayListButton: {
                }
                .padding()
    }
    private var listRows : some View {
        ForEach(productRows) { row in
            VStack(spacing : 16) {
                Text(row.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth : .infinity , alignment: .leading)
                    .padding()
                ScrollView(.horizontal) {
                    HStack(alignment : .top, spacing : 16) {
                        ForEach(row.products) { product in
                            ScrollRowCell(imageName: product.firstImage , text: product.title, size: 120)
                                .asButton(.press) {
                                    showRecentPlaylist(product: product)
                                }
                                
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal , 10)
              
            }
            
//                    .themeColors(isSelected: false)
        }
    }
    func showRecentPlaylist(product : Product){
        guard let user = currentUser else { return }
        router.showScreen{ _ in
            SpotifyPlalist(product: product , user:  user)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()
    }
}

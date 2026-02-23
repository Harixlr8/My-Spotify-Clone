//
//  SpotifyPlalist.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/12/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlalist: View {
    @Environment(\.router) var router
    var product : Product = .mock
    var user : User = .mock
    @State var products : [Product] = []
    @State private var showHeader : Bool = true
    @State private var offset : CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            ScrollView {
                LazyVStack(spacing : 12) {
                    PlaylistHeaderCell(
                        image : product.images.first ?? Constants.randomImage,
                        height: 250 ,
                        title: product.title ,
                        subtitle: product.category
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 170
                    }
                }
                PlaylistDescription(
                    descriptionText: product.description ,
                    userName: user.firstName ,
                    subHeadline: product.category ,
                    onAddToPlaylistPressed: nil,
                    onDownloadPressed: nil,
                    onSharedPressed: nil,
                    onElipsisPressed: nil,
                    onShufflePressed: nil,
                    onPlayPressed: nil
                )
                ForEach(products) { product in
                    SongRowCell(
                        size: 70,
                        imageName: product.firstImage,
                        songName: product.title,
                        songCategory: product.category
                    ) {
                        showRecentPlaylist(product: product)
                    } onElipsisPressed: {
                        
                    }

                }
            }
            
           header
            .foregroundStyle(.spotifyWhite)
            .animation(.smooth, value: showHeader)
            .frame(maxHeight : .infinity , alignment: .top)
            
        }
        .task {
            await fetchData()
        }
        .navigationBarBackButtonHidden(true)
    }
        
    func fetchData() async  {
        do {
            
            products = try await DatabaseHelper().getProducts()
        } catch  {
             print(error)
        }
    }
    private var header : some View {
        ZStack {
            Text(product.title)
                .font(.title)
                .padding(.vertical , 20)
                .frame(maxWidth : .infinity)
                .offset(y : showHeader ? 0 : -40)
                .background(.spotifyBlack)
                .opacity(showHeader ? 1 : 0)
            ZStack {
                Image(systemName: "chevron.left")
                    .padding()
                    .font(.title2)
                    .background(showHeader ? Color.black.opacity(0.001) : Color.spotifygray.opacity(0.7))
                    .clipShape(.circle)
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading , 20)
            
        }
    }
    func showRecentPlaylist(product : Product){
        router.showScreen{ _ in
            SpotifyPlalist(product: product , user:  user)
        }
    }

}

#Preview {
    SpotifyPlalist()
}

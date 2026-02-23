//
//  PlaylistHeaderCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/12/25.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var image : String = Constants.randomImage
    var height : CGFloat = 300
    var title : String = "Playlist title"
    var subtitle : String = "Playlist subtitle"
    var shadowColor : Color = .spotifyBlack.opacity(0.8)
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoaderView(urlString: image)
            }
            .overlay(alignment : .bottomLeading) {
                VStack(alignment : .leading, spacing : 8) {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.spotifyLightGray)
                    Text(title)
                        .font(.largeTitle)
                        .foregroundStyle(.spotifyWhite)
                }.padding()
                .fontWeight(.semibold)
                .frame(maxWidth : .infinity, alignment:  .leading)
                .background(
                    LinearGradient(colors: [shadowColor.opacity(0) , shadowColor], startPoint: .top, endPoint: .bottom)
                )
                
            }
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}

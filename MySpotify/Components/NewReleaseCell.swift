//
//  NewReleaseCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import SwiftUI

struct NewReleaseCell: View {
    var imageName : String = Constants.randomImage
    var headline : String? = "New Releases"
    var subheadline : String? = "Some Artists"
    var title : String? = "Song title"
    var subtitle : String? = "The song goes lingo"
    var OnPlayPressed : (() -> Void)? = nil
    var addToPlayListButton : (() -> Void)? = nil
    
    var body: some View {
        VStack {
            imageRow
            musicPlay
        }
    }
    
    private var imageRow : some View {
        HStack {
            ImageLoaderView(urlString: imageName)
                .frame(width: 50 , height:  50 )
                .clipShape(.circle)
            VStack(alignment : .leading) {
                if let headline {
                    Text(headline)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                        
                }
                if let subheadline {
                    Text(subheadline)
                        .font(.title2)
                        .foregroundStyle(.spotifyWhite)
                        .fontWeight(.semibold)
                }
            }
            Spacer()
        }
    }
    private var musicPlay : some View {
        HStack(spacing : 4) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 150 , height:  150 )
            VStack(alignment : .leading , spacing:  32) {
                VStack(alignment: .leading, spacing: 4) {
                        if let title {
                            Text(title)
                                .foregroundStyle(.spotifyWhite)
                                .fontWeight(.semibold)
                        }
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotifyLightGray)
                        }
                }
                .font(.callout)
                HStack {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.spotifyLightGray)
                        .font(.title3)
                        .padding(4)
                        .background(.black.opacity(0))
                        .offset(x : -4)
                        .onTapGesture {
                            addToPlayListButton?()
                        }
                        .frame(maxWidth : .infinity , alignment : .leading)
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(.spotifyWhite)
                        .font(.title3)
                }
            }
            .padding(.horizontal)
        }
        .themeColors(isSelected: false)
        .cornerRadius(10)
        .onTapGesture {
            OnPlayPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        VStack {
            NewReleaseCell()
        }
    }
}

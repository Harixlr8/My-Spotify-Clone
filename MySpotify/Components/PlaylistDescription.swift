//
//  PlaylistDescription.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/12/25.
//

import SwiftUI

struct PlaylistDescription: View {
    var descriptionText : String = Product.mock.description
    var userName : String = "Hari"
    var subHeadline : String = "Subheadline of some type.."
    
    var onAddToPlaylistPressed : (() -> Void)? = nil
    var onDownloadPressed : (() -> Void)? = nil
    var onSharedPressed : (() -> Void)? = nil
    var onElipsisPressed : (() -> Void)? = nil
    var onShufflePressed : (() -> Void)? = nil
    var onPlayPressed : (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment : .leading , spacing: 10){
            Text(descriptionText)
                .lineLimit(2)
            HStack {
                Image(systemName: "applelogo")
                    .font(.title3)
                    .foregroundStyle(.spotifyGreen)
                Text("Made for")
                    .foregroundStyle(.spotifyLightGray)
                Text("\(userName)")
                    .font(.title3)
            }
            Text(subHeadline)
            
            HStack(spacing : 0) {
                HStack(spacing : 0){
                    Image(systemName: "plus.circle")
                        .padding(6)
                        .onTapGesture {
                            onAddToPlaylistPressed
                        }
                    Image(systemName: "arrow.down.circle")
                        .padding(6)
                        .onTapGesture {
                            onDownloadPressed
                        }
                    Image(systemName: "square.and.arrow.up")
                        .padding(6)
                        .onTapGesture {
                            onSharedPressed
                        }
                    Image(systemName: "ellipsis")
                        .padding(6)
                        .onTapGesture {
                            onElipsisPressed
                        }
                }
                Spacer()
                HStack {
                    Image(systemName: "shuffle")
                        .padding(.trailing , 8)
                        .onTapGesture {
                            onShufflePressed
                        }
                    Image(systemName: "play.circle.fill")
                        .padding(.trailing , 16)
                        .onTapGesture {
                            onPlayPressed
                        }
                }
                .foregroundStyle(.spotifyGreen)
                .font(.title)
            }
            .font(.title3)
        }
        .font(.callout)
        .foregroundStyle(.spotifyLightGray)
        .fontWeight(.medium)
    }
    
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        PlaylistDescription()
    }
}

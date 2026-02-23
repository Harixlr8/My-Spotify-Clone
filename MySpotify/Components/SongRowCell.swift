//
//  SongRowCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/12/25.
//

import SwiftUI

struct SongRowCell: View {
    var size : CGFloat = 100
    var imageName : String = Constants.randomImage
    var songName : String = "Raavera aay"
    var songCategory : String = "Malayalm Sad"
    var onCellPressed : (() -> Void)? = nil
    var onElipsisPressed : (() -> Void)? = nil
    
    var body: some View {
        HStack {
            ImageLoaderView(urlString: imageName)
                .frame(width: size , height:  size)
                .cornerRadius(6)
            VStack(alignment: .leading){
                Text(songName)
                    .foregroundStyle(.spotifyWhite)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(songCategory)
                    .foregroundStyle(.spotifyLightGray)
                    .font(.callout)
            }
            Spacer()
            Image(systemName: "ellipsis")
                .foregroundStyle(.spotifyWhite)
                .font(.title)
                .padding() 
                .onTapGesture {
                    onElipsisPressed?()
                }
        }
        .onTapGesture {
            onCellPressed?()
        }
    }
    
}

#Preview {
    ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        SongRowCell()
    }
}

//
//  ScrollRowCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/12/25.
//

import SwiftUI

struct ScrollRowCell: View {
    var imageName : String = Constants.randomImage
    var text : String = "Some text refdsgfsagdsfgda"
    var size : CGFloat = 100
    var body: some View {
        VStack(alignment : .leading , spacing : 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: size , height:  size)
                .cornerRadius(4)
            Text(text)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(2)
                .padding(.trailing , 4)
            
        }
        .frame(width:  size)
        .padding(.bottom , 6)
        
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
        ScrollRowCell()
    }
}

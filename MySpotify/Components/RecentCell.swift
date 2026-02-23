//
//  RecentCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import SwiftUI

struct RecentCell: View {
    var imageString : String = Constants.randomImage
    var title : String = "Some random title"
    var body: some View {

        ZStack {
            HStack(spacing : 16) {
                ImageLoaderView(urlString: imageString)
                    .frame(width: 55,height: 55)
                Text(title)
                    .lineLimit(2)
                
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment:  .leading)
            .themeColors(isSelected: false)
            .cornerRadius(6)
        }
    }
}

#Preview {
    VStack {
        HStack {
            RecentCell()
            RecentCell()
        }
    }
}

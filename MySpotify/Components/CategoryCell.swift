//
//  CategoryCell.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/12/25.
//

import SwiftUI

struct CategoryCell: View {
     var title : String = "Music"
     var isSelected : Bool = false
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            Text(title)
                .font(.callout)
                .frame(minWidth: 40)
                .padding(.vertical,8)
                .padding(.horizontal, 10)
                .themeColors(isSelected: isSelected)
                .cornerRadius(16)
        }
    }
}
extension View {
    func themeColors(isSelected : Bool)  -> some View {
        self
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDarkGrey)
    }
}

#Preview {
    CategoryCell()
}

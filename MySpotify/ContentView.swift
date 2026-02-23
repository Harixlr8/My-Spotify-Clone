//
//  ContentView.swift
//  MySpotify
//
//  Created by Harikrishnan on 14/12/25.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    var body: some View {
        VStack {
            Button("Open Spotify") {
                router.showScreen { _ in
                    SpotifyHomeView()
                }
            }
        }
        .padding()
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}

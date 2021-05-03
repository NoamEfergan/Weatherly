//
//  ImageView.swift
//  Weatherly
//
//  Created by Noam Efergan on 03/05/2021.
//

import SwiftUI

struct ImageView: View {
    let url: URL

    @StateObject private var image = FetchImage()

    var body: some View {
        ZStack {
            Circle().fill(Color.white)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
        }
        .onAppear { image.load(url) }
        .onChange(of: url) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}


//
//  PhotoPickerS.swift
//  MySpotify
//
//  Created by Harikrishnan on 08/02/26.
//

import SwiftUI
import PhotosUI

struct PhotoPickerSPage: View {
    @State var pickedPhot : PhotosPickerItem? = nil
    @State var pickedPhotos : [PhotosPickerItem] = []
    
    @State var image : UIImage? = nil
    @State var images : [UIImage] = []
    var body: some View {
        VStack {
            
            if !images.isEmpty {
               
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(images,id: \.self) { image in
                                
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200 , height: 200)
                          
                               
                            }
                        }
                    
                    
                }
                
            }
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
//            PhotosPicker("Pick Photo", selection: $pickedPhot,photoLibrary: .shared())
//            
//            .onChange(of: pickedPhot) { _, newItem in
//                
//                Task {
//                    let data = try? await newItem?.loadTransferable(type: Data.self)
//                    if let data {
//                        let uIImage = UIImage(data: data)
//                        await MainActor.run {
//                            image = uIImage
//                        }
//                    }
//                }
//            }
            PhotosPicker(selection: $pickedPhotos) {
                Text("Select Photos")
            }
            .onChange(of: pickedPhotos) { _, items in
                images.removeAll()
                Task {
                    for item in items {
                        let data = try? await item.loadTransferable(type: Data.self)
                        if let data {
                            let uiImage = UIImage(data: data)
                            if let uiImage {
                                await MainActor.run {
                                    images.append(uiImage)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PhotoPickerSPage()
}

//
//  PhotoTest.swift
//  MySpotify
//
//  Created by Harikrishnan on 16/01/26.
//

import SwiftUI
import PhotosUI

struct SinglePhotoPicker : View {
    @State private var selectedItem : PhotosPickerItem? = nil
    @State private var image : UIImage? = nil
    @State private var selectedItems : [PhotosPickerItem] = []
    @State private var images : [UIImage] = []
    var body: some View {
        VStack(spacing: 20, content: {
//            if let uiImage = image {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFit()
//            }
//            PhotosPicker(selection: $selectedItem,matching: .any(of: [.images , .videos]) ,photoLibrary: .shared()) {
//                Text("Select photo")
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.blue)
//                    .cornerRadius(10)
//                    .onChange(of: selectedItem) { _, newItem in
//                       
//                    }
//            }
                
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images,id:  \.self){ imageItem in
                        
                            Image(uiImage: imageItem)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200 )
                        
                    }
                }

            }
//            PhotosPicker(selection: $selectedItems,maxSelectionCount: 4 ,photoLibrary: .shared())
//            {
//                Text("Pick Photo's")
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.blue)
//                    .cornerRadius(8)
//            }
//            .onChange(of: selectedItems) { _ , newItems in
//                images.removeAll()
//                for item in newItems {
//                    Task {
//                        do {
//                            if let data = try await item.loadTransferable(type: Data.self),
//                            let image = UIImage(data: data){
//                                await MainActor.run {
//                                    images.append(image)
//                                }
//                            }
//                            
//                            
//                        } catch  {
//                            
//                        }
//                    }
//                }
//            }
            
            
                   PhotosPicker(selection: $selectedItems, photoLibrary: .shared()) {
                Text("Pick Photo")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
            }
            .onChange(of: selectedItems) { _, newItems in
                
               // loadImage(item: newItem)
                loadImages(items: newItems)
            }
          

        })
    }
    func loadImages(items : [PhotosPickerItem]){
        images.removeAll()
        for item in items {
            Task {
                let data = try? await item.loadTransferable(type: Data.self)
                if let data ,
                   let image = UIImage(data: data) {
                    await MainActor.run {
                    images.append(image)
                }
            }
            }
        }
    }
    func loadImage(item : PhotosPickerItem){
        Task {
            let data = try? await item.loadTransferable(type: Data.self)
            if let data {
                let image = UIImage(data: data)
                await MainActor.run {
                    self.image = image
                }
            }
        }
    }
//    func loadImage(item : PhotosPickerItem?){
//        guard let item  else { return }
//        Task {
//            let data = try? await item.loadTransferable(type: Data.self)
//            if let imageData = data {
//                let uiImage = UIImage(data: imageData)
//                await MainActor.run {
//                    self.image = uiImage
//                }
//            }
//        }
//    }
//    func loadImage(item : PhotosPickerItem?){
//        guard let item else { return }
//        Task {
//            let imageData = try? await item.loadTransferable(type: Data.self)
//            if let data = imageData {
//                let uiImage = UIImage(data: data)
//               await MainActor.run {
//                    self.image = uiImage
//                }
//            }
            
        }
    


#Preview {
    SinglePhotoPicker()
}

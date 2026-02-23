//
//  test.swift
//  MySpotify
//
//  Created by Harikrishnan on 15/01/26.
//

import SwiftUI
import Combine

struct Test :  View {
//    @State var items = Array(0..<15)
//    @State var isLoading : Bool = false
    @StateObject private var vm = DataViewModel()
    
    
    var body: some View {
//        ScrollView {
//            LazyVStack {
//                ForEach(items , id : \.self) { item in
//                Text("Product \(item+1)")
//                        .onAppear {
//                            if item == items.last
//                            {
////                                loadMore()
//                            }
//                        }
//                        .padding()
//                }
//                if isLoading{
//                    ProgressView()
//                }
//            }
//
//        }
        
        NavigationStack {
            if(vm.isLoading){
                ProgressView()
            }
            ScrollView {
                ForEach(vm.data){ item in
                    Text(item.name)
                }
            }
        }
        .task {
           await vm.fetchData()
        }
        
    }
//    func loadMore(){
//        guard !isLoading else { return }
//        isLoading = true
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            let next = items.count
//            items.append(contentsOf: Array(next..<next+10))
//            isLoading = false
//        }
//    }
}

#Preview {
    Test()
}

struct DataModel : Identifiable , Codable {
    let id : Int
    let name : String
}

class DataService {
    func fetchData() async throws ->[DataModel] {
        guard let url = URL(string: "") else { throw URLError(.badURL) }
        
        
          let (data,_) =  try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([DataModel].self, from: data)
    }
}

class DataViewModel : ObservableObject {
    
    @Published var data : [DataModel] = []
    @Published var isLoading = false
    var service  = DataService()
    
//    var instance : MySingleTon = MySingleTon()
    
    func fetchData() async {
        isLoading = true
        
        do {
            self.data = try await  service.fetchData()
        } catch  {
            print(error)
        }
        isLoading = false
       
    }
}


class MySingleTon{
    static let instance = MySingleTon()
    private init() { }
}

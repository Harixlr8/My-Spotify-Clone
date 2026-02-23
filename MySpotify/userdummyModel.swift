//
//  userdummyModel.swift
//  MySpotify
//
//  Created by Harikrishnan on 08/02/26.
//


import Foundation
import SwiftUI
import Combine

// MARK: - USERElement
struct USERElement: Codable , Identifiable {
    let id: Int
    let name, username, email: String
    
    let phone, website: String
}
class UserViewModel : ObservableObject{
    @Published var users : [USERElement] = []
    @Published var errorString : String = ""
    @Published var isLoading : Bool = false
    
    var url : String = "https://jsonplaceholder.typicode.com/users"
    
    init(){
        fetchUsers2 { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                self?.errorString = error.localizedDescription
            }
            
        }
//        Task {
//            await fetchUsers()
//        }
    }
    func fetchUsers() async  {
        isLoading = true
        guard let url = URL(string: url) else { return }
        do {
            let (data , _ ) = try await URLSession.shared.data(from: url)
            users = try JSONDecoder().decode([USERElement].self, from: data)
        } catch  {
            errorString = error.localizedDescription
        }
        isLoading = false
    }
    func fetchUsers2(completion : @escaping (Result<[USERElement] , Error>) -> Void) {
        isLoading = true
        guard let url = URL(string: url) else {
           return completion(.failure(URLError(.badURL)))
        }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode( [USERElement].self , from: data)
                        completion(.success(user))
                    } catch  {
                        completion(.failure(error))
                    }
                }
                
            }
        }
        .resume()
    }
    //isLoading = true
    //guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
    //
    //do {
    //    let (data , _ ) = try await URLSession.shared.data(from: url)
    //    users = try JSONDecoder().decode([USERElement].self, from: data)
    //}
    //catch {
    //    errorString = error.localizedDescription
    //}
    //isLoading = false
}
struct UserView : View {
    
    
    @StateObject private var vm = UserViewModel()
    
    var body : some View {
        VStack {
            if vm.isLoading {
                ProgressView()
            }
            if !vm.errorString.isEmpty {
                Text(vm.errorString)
            }
            List {
                ForEach(vm.users) { user in
                    Text(user.name)
                }
            }
            .listStyle(.plain)
        }    }
}
#Preview {
    UserView()
}

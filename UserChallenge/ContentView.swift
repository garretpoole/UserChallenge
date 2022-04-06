//
//  ContentView.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/6/22.
//

import SwiftUI

struct Response: Codable {
    var users: [User]
}

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        List(users, id: \.name){ user in
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.isActive ? "Active" : "Not Active")
            }
        }
        .task{
            //'await' must be used for async functions
            if(users.isEmpty){
                print("loadData")
                await loadData()
            }
        }
    }
    
    func loadData() async{
        print("loading...")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else{
            print("Invalid URL")
            return
        }
        do {
            //return is a tuple with data and metadata
            let (data, _) = try await URLSession.shared.data(from: url)
            //convert data object into Response
            print(data.description)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedUsers = try? decoder.decode([User].self, from: data){
                print("set users")
                self.users = decodedUsers
            }
        } catch{
            print("Invalid data")
        }
        print("Done")
        print(users.isEmpty)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

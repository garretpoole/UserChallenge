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
    @Environment(\.managedObjectContext) var moc
    @State private var users = [User]()
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView{
            List(cachedUsers, id: \.id){ cachedUser in
                NavigationLink{
                    UserDetailsView(user: cachedUser)
                } label: {
                    VStack(alignment: .leading) {
                        Text(cachedUser.wrappedName)
                            .font(.headline)
                        Text(cachedUser.isActive ? "Active" : "Not Active")
                            .foregroundColor(cachedUser.isActive ? Color.green : Color.red)
                    }
                }
            }
            .task{
                //'await' must be used for async functions
                if(users.isEmpty){
                    await loadData()
                }
                await cacheData()
                
            }
            .navigationTitle("UserChallenge")
        }
    }
    
    func cacheData() async{
        await MainActor.run{
            for user in users{
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = user.id
                cachedUser.isActive = user.isActive
                cachedUser.name = user.name
                cachedUser.age = Int16(user.age)
                cachedUser.company = user.company
                cachedUser.email = user.email
                cachedUser.address = user.address
                cachedUser.about = user.about
                cachedUser.registered = user.registered
                cachedUser.tags = user.tags.joined(separator: ",")
                var cachedFriends = [CachedFriend]()
                for friend in user.friends{
                    let cached = CachedFriend(context: moc)
                    cached.id = friend.id
                    cached.name = friend.name
                    cachedFriends.append(cached)
                }
                cachedUser.friends = "cachedFriends"
                try? moc.save()
            }
        }
    }
    
    
    func loadData() async{
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
            List(users, id: \.id){ user in
                NavigationLink{
                    UserDetailsView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.isActive ? "Active" : "Not Active")
                            .foregroundColor(user.isActive ? Color.green : Color.red)
                    }
                }
            }
            .task{
                //'await' must be used for async functions
                if(users.isEmpty){
                    await loadData()
                }
                
            }
            .navigationTitle("UserChallenge")
        }
    }
    
    func cacheData(data: User){
        let user = CachedUser(context: moc)
        user.id = data.id
        user.isActive = data.isActive
        user.name = data.name
        user.age = Int16(data.age)
        user.company = data.company
        user.email = data.email
        user.address = data.address
        user.about = data.about
        user.registered = data.registered
        user.tags = data.tags.joined(separator: ",")
        var cachedFriends = [CachedFriend]()
        for friend in data.friends{
            let cached = CachedFriend(context: moc)
            cached.id = friend.id
            cached.name = friend.name
            cachedFriends.append(cached)
        }
        user.friends = cachedFriends
        try? moc.save()
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

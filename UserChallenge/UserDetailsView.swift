//
//  UserDetailsView.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/6/22.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text(user.isActive ? "Active" : "Not Active")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                    NavigationLink{
                        FriendView(friends: user.friends)
                    } label: {
                        Text("Friends")
                            .padding()
                            .foregroundColor(.secondary)
                            .font(.headline)
                    }
                }
                Spacer()
                Text(user.about)
                Spacer()
                VStack(alignment: .leading){
                    HStack{
                        Text("Email: ")
                            .font(.headline)
                        Text(user.email.isEmpty ? "NA" : user.email)
                    }
                    HStack{
                        Text("Address: ")
                            .font(.headline)
                        Text(user.address.isEmpty ? "NA" : user.address)
                    }
                    if !user.company.isEmpty{
                        HStack{
                            Text("Company: ")
                                .font(.headline)
                            Text(user.company)
                        }
                    }
                }
                Spacer()
                HStack{
                    Text("Tags: ")
                        .font(.headline)
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(user.name)
        //.navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User(id: "2", isActive: true, name: "J", age: 12, company: "kdkd", email: "@", address: "", about: "akjsdncvojasnvjkasnjkvnaklsjnvnasfvnladsnfvodnsfojvnojadfnvjdnjfvnajkfnvknakfvnoaksnvkanslkvnlkasfnvlkasnklvnaskvn vasvnkasnvokasnv asvnasoknva k jnajn fvkjan s jnsjvn ka fvjon ", registered: Date.now, tags: ["lol", "lmao"], friends: [Friend(id: "lol", name: "K")]))
    }
}

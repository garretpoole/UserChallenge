//
//  UserDetailsView.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/6/22.
//

import SwiftUI

struct UserDetailsView: View {
    let user: CachedUser
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Text(user.isActive ? "Active" : "Not Active")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                    NavigationLink{
                        Text("Friends")
                        //FriendView(friends: user.friends)
                    } label: {
                        Text("Friends")
                            .padding()
                            .foregroundColor(.secondary)
                            .font(.headline)
                    }
                }
                Spacer()
                Text(user.wrappedAbout)
                Spacer()
                VStack(alignment: .leading){
                    HStack{
                        Text("Email: ")
                            .font(.headline)
                        Text(user.wrappedEmail.isEmpty ? "NA" : user.wrappedEmail)
                    }
                    HStack{
                        Text("Address: ")
                            .font(.headline)
                        Text(user.wrappedAddress.isEmpty ? "NA" : user.wrappedAddress)
                    }
                    if !user.wrappedCompany.isEmpty{
                        HStack{
                            Text("Company: ")
                                .font(.headline)
                            Text(user.wrappedCompany)
                        }
                    }
                }
                Spacer()
                HStack{
                    Text("Tags: ")
                        .font(.headline)
                    Text(user.tags ?? "NA")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .navigationTitle(user.wrappedName)
    }
}

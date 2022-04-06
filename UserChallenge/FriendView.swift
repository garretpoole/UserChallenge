//
//  FriendView.swift
//  UserChallenge
//
//  Created by Garret Poole on 4/6/22.
//

import SwiftUI

struct FriendView: View {
    let friends: [Friend]
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(friends, id: \.id) { friend in
                    Text(friend.name)
                        .font(.headline)
                    
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
        }
        .navigationTitle("Friends")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView(friends: [Friend(id: "1", name: "3")])
    }
}

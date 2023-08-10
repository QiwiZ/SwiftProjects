//
//  UserDetailView.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-28.
//

import SwiftUI

struct UserDetailView: View {
    var user: CachedUser
    
    var body: some View {
        NavigationView {
            VStack {
                Section("User Info") {
                    VStack {
                        HStack {
                            Text("Age: \(user.age)")
                            Text(user.wrappedEmail)
                            Text(user.wrappedCompany)
                        }
                        Text(user.wrappedAddress)
                    }
                    
                }
                
                List {
                    ForEach(user.friendsArray, id:\.self) { friend in
                        Text(friend.wrappedName)
                    }
                }
                
            }.navigationTitle(user.wrappedName)
        }
        
    }
}

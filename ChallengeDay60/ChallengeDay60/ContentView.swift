//
//  ContentView.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-27.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(cachedUsers, id:\.self) { user in
                        NavigationLink {
                            UserDetailView(user: user)
                        } label: {
                            HStack {
                                Text(user.wrappedName)
                                Text(user.isActive ? "Active" : "Inactive")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.task {
                    await fetchUsers()
                    await saveUsersToDb()
                }.padding()
            }.navigationTitle("Contacts")
        }
    }
    func fetchUsers() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([User].self, from: data)
            users = decoded
        } catch {
            print(String(describing: error))
        }
    }
    
    func saveUsersToDb() async {
        await MainActor.run {
            users.forEach { user in
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = user.id
                cachedUser.about = user.about
                cachedUser.address = user.address
                cachedUser.age = Int16(user.age)
                cachedUser.company = user.company
                cachedUser.email = user.email
                cachedUser.isActive = user.isActive
                cachedUser.name = user.name
                
                var cachedFriends: [CachedFriend] = []
                user.friends.forEach { friend in
                   let cachedFriend = CachedFriend(context: moc)
                    cachedFriend.name = friend.name
                    cachedFriends.append(cachedFriend)
                }
                
                cachedUser.cachedFriends = NSSet(array: cachedFriends)
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

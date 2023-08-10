//
//  ContentView.swift
//  Bookworm
//
//  Created by Julian Saxl on 2023-07-22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var isAddingBook = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? Color.red : Color.black)
                                Text(book.author ?? "Unkown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }.onDelete(perform: onDeleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isAddingBook.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
        }.sheet(isPresented: $isAddingBook) {
            AddBookView()
        }
    }
    
    func onDeleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

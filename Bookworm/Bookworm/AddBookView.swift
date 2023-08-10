//
//  AddBook.swift
//  Bookworm
//
//  Created by Julian Saxl on 2023-07-24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    func isValidForm() -> Bool {
        return !(title.isEmpty || author.isEmpty || genre.isEmpty)
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title of the book", text: $title)
                    TextField("Author of the book", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: managedObjectContext)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.review = review
                        newBook.rating = Int16(rating)
                        newBook.date = Date.now
                        
                        try? managedObjectContext.save()
                        dismiss()
                    }.disabled(!isValidForm())
                }
            }.navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

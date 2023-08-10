//
//  DetailView.swift
//  Bookworm
//
//  Created by Julian Saxl on 2023-07-24.
//
import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.date!, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(book.review ?? "No review")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
        }.navigationTitle(book.title ?? "Unknown Title")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Delete Book", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {deleteBook()}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete this book?")
            }
            .toolbar {
                Button {
                    showingDeleteAlert.toggle()
                } label: {
                    Label("Delete this book.", systemImage: "trash")
                }
            }
    }
    
    func deleteBook() {
        moc.delete(book)
        dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.author = "Author"
        book.title = "Title"
        book.genre = "Fantasy"
        book.rating = 1
        book.review = "Eh; Alright"
        
        return DetailView(book: book)
    }
}

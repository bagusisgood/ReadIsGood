//
//  AddBookView.swift
//  ReadIsGood
//
//  Created by Bagus Triyanto on 11/07/20.
//  Copyright © 2020 BagusIsGood. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    // read environment wrapper for CoreData
    @Environment(\.managedObjectContext) var moc
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    // Set initial value & binding for the form
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Unknown"
    @State private var review = ""
    
    // provide list of genres
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Academics", "Sci-Fi", "Unknown"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Section(header: Text("Review & Rating")) {
                    Picker("Rating", selection: $rating) {
                        ForEach(0 ..< 6) {
                            Text("\($0)")
                        }
                    }
                    
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        // create instance of Book class
                        let newBook = Book(context: self.moc)
                        
                        // copy value from form to the core data/ book instance
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.genre = self.genre
                        newBook.rating = Int16(self.rating)
                        newBook.review = self.review
                        
                        // save the instance into core data
                        try? self.moc.save()
                        
                        // dismiss sheetview
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
            }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

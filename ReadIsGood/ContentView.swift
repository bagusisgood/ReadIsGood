//
//  ContentView.swift
//  ReadIsGood
//
//  Created by Bagus Triyanto on 11/07/20.
//  Copyright © 2020 BagusIsGood. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack (alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unkown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: removeBooks)
                
            }
                .navigationBarTitle("READisgood")
                .navigationBarItems(
                    
                    leading: EditButton(),
                    
                    trailing: Button(action: {
                    self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                        
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
            }
            
        }
    }
    
    func removeBooks(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            moc.delete(book)
        }
        
        do {
            try moc.save()
        } catch {
            // handle the Core Data error
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
#endif

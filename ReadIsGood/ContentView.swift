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
            VStack {
                Text("Count: \(books.count)")
            }
                .navigationBarTitle("ReadIsGood")
                .navigationBarItems(trailing: Button(action: {
                    self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
            }
            
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

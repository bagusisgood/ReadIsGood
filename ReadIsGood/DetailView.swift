//
//  DetailView.swift
//  ReadIsGood
//
//  Created by Bagus Triyanto on 12/07/20.
//  Copyright © 2020 BagusIsGood. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                        .padding()
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                ZStack{
                    VStack {
                        Text(self.book.title ?? "Unknown Title")
                            .font(.title)
                            .bold()
                        Text(self.book.author ?? "Unknown Author")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(self.book.review ?? "No review")
                            .lineLimit(3)
                            .multilineTextAlignment(.center)

                        RatingView(rating: .constant(Int(self.book.rating)))
                    }
                    .padding(40)
                    .frame(width: 300, height: 400)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    
                }
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        
        book.title = "Test title"
        book.author = "Test author"
        book.rating = 4
        book.review = "No review"
        book.genre = "Fantasy"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}

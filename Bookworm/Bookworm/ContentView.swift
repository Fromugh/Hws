//
//  ContentView.swift
//  Bookworm
//
//  Created by H. Sungjae on 6/24/26.
//

import SwiftUI; import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                
//                .onDelete(perform: {(offsets: IndexSet) -> Void in
//                    for offset in offsets {
//                        let book = books[offset]
//                        
//                        modelContext.delete(book)
//                    }
//                })
//                .onDelete{ offsets in
//                    for offset in offsets {
////                        let book = books[offset]
//                    
//                        modelContext.delete(books[offset])
//                    }
//                }                             // .onDelete(perform: {(_ : IndexSet) -> Void }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  iExpense
//
//  Created by H. Sungjae on 3/18/26.
//

import SwiftUI
import Observation

//@Observable
//class User {
//    var firstName = "Bilbo"
//    var lastName = "Baggins"
//}

//struct User: Codable {
//    let firstName: String
//    let lastName: String
//}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            do {
                let decodedItems = try JSONDecoder().decode([ExpenseItem].self, from: savedItems)
                items = decodedItems
            } catch {
                print("Failed to load items from UserDefaults")
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var title = "iExpense"
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)) {
                    Image(systemName: "plus")
                }
            }
        }
//        .sheet(isPresented: $showingAddExpense) {
//            AddView(expenses: expenses)
//        }
    }
}

//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//    let name: String
//    
//    var body: some View {
//        Button("Dismiss") {
//            print(type(of: dismiss))
//            dismiss()
//        }
//    }
//}

#Preview {
    ContentView()
}

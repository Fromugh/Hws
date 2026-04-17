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
    
//    @State private var user = User()
    
//    @State private var showingSheet = false
    
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
    
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    @AppStorage("tapCount") private var tapCount = 0
    
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")
    
    @State private var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    @State private var showingAddExpense = false

    var body: some View {
//        VStack {
//            Text("Your name is \(user.firstName) \(user.lastName).")
//            
//            TextField("First name", text: $user.firstName)
//            TextField("Last name", text: $user.lastName)
//        }
        
//        Button("Show Sheet"){
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "@twostraws")
//        }
        
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("Row: \($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//                
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .toolbar {
//                EditButton()
//            }
//        }
        
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//        }
        
//        Button("Save User") {
//            let encoder = JSONEncoder()
//            
//            if let data = try? encoder.encode(user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
        
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
            .navigationTitle("iExpense")
            .toolbar {
                Button("add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
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

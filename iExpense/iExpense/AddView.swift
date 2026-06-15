//
//  AddView.swift
//  iExpense
//
//  Created by H. Sungjae on 3/19/26.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types = ["Business", "Personal"]
    var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem (placement: .cancellationAction){
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

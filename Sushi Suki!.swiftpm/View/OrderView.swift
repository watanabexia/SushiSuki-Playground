//
//  OrderView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/5/23.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var sushiDB: SushiDB
    @ObservedObject var meal: Meal
    
    @State private var showReceipt = false
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    showReceipt.toggle()
                } label: {
                    Text("Receipt")
                }
                .padding(.leading)
                
                Spacer()
                
                Button {
                    meal.sushis.insert(customizedNigiri.copy(), at: 0)
                } label: {
                    Image(systemName: "plus.circle")
                }
                .padding(.trailing, 20)
            }
            
            List {
                ForEach(meal.sushis) { sushi in
                    DisclosureGroup {
                        ForEach(sushi.ingredients) { ingredient in
                            IngredientCellView(ingredient: ingredient)
                        }
                        .onMove(perform: .none)
                        .onDelete { indexSet in
                            sushi.ingredients.remove(atOffsets: indexSet)
                            meal.objectWillChange.send()
                        }
                    } label: {
                        SushiCellView(sushi: sushi)
                    }
                }
                .onMove() { from, to in
                    meal.sushis.move(fromOffsets: from, toOffset: to)
                    
                    print("\(from), \(to)")
                }
                .onDelete { index in
                    meal.sushis.remove(atOffsets: index)
                }
            }
            .toolbar {
                EditButton()
            }
            
            Button {
                meal.sushis = []
            } label: {
                Text("CLEAR ALL")
            }
            .padding(.bottom, 30)
        }
        .sheet(isPresented: $showReceipt) {
            ReceiptView(meal: meal)
        }
    }
}

struct SushiCellView: View {
    
    @State var isEditing = false
    @ObservedObject var sushi: Sushi
    
    var body: some View {
        
        if (isEditing) {
            TextField("sushi name", text: $sushi.name)
                .onSubmit {
                    self.isEditing = false
                }
        } else {
            Text(sushi.name)
                .swipeActions(edge: .leading) {
                    Button {
                        self.isEditing = true
                    } label: {
                        Text("Rename")
                    }
                }
        }
    }
}

struct IngredientCellView: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            if ingredient.assetName != nil {
                AssetCellView(ingredient: ingredient)
            }
            Text(ingredient.name)
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(meal: mealPreview)
    }
}

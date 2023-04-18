//
//  IngredientView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/6/23.
//

import SwiftUI

struct IngredientView: View {
    @EnvironmentObject var sushiDB: SushiDB
    @ObservedObject var meal: Meal
    
    var body: some View {
        VStack {
            Text("Ingredient")
                .font(.title)
                .bold()
            
            List {
                ForEach(Array(sushiDB.ingredientListDict).reversed(), id: \.key) { key, value in
                    DisclosureGroup {
                        ForEach(value) { ingredient in
                            IngredientManualCellView(ingredient: ingredient, meal: meal)
                        }
                    } label: {
                        Text(key)
                    }
                }
            }
        }
    }
}

struct IngredientManualCellView: View {
    let ingredient: Ingredient
    @ObservedObject var meal: Meal
    
    var body: some View {
        HStack {
            Button {
                if meal.sushis.count > 0 {
                    meal.sushis[0].ingredients.insert(ingredient.copy(), at: 0)
                    meal.objectWillChange.send()
                }
            } label: {
                IngredientCellView(ingredient: ingredient)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.accentColor)
            }
        }
    }
}

struct IngredientView_Previews: PreviewProvider {
    static let sushiDBPreview = SushiDB()
    
    static var previews: some View {
        IngredientView(meal: mealPreview)
            .environmentObject(sushiDBPreview)
    }
}

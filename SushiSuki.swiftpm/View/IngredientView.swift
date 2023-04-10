//
//  IngredientView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/6/23.
//

import SwiftUI

struct IngredientView: View {
    
    @ObservedObject var meal: Meal
    
    var body: some View {
        
        
        VStack {
            Text("Ingredient")
                .font(.title)
                .bold()
            
            List {
                ForEach(allIngridentLists) { ingredientList in
                    DisclosureGroup {
                        if let ingredients = ingredientList.ingredients {
                            ForEach(ingredients) { ingredient in
                                IngredientManualCellView(ingredient: ingredient, meal: meal)
                            }
                        }
                    } label: {
                        Text(ingredientList.name)
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
                    meal.sushis[0].ingredients?.insert(ingredient.copy(), at: 0)
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
    static var previews: some View {
        IngredientView(meal: mealPreview)
    }
}

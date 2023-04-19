//
//  ReceiptView.swift
//  
//
//  Created by Qingyang Xu on 4/19/23.
//

import SwiftUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    
    let meal: Meal
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Receipt")
                    .font(.largeTitle)
                    .bold()
                Text("~ Enjoy your meal ~")
                    .font(.custom("Georgia", size: 24))
                    .italic()
                Text("Generated on \(Date.now.formatted())")
                    .padding()
                
                ForEach(meal.sushis) { sushi in
                    DisclosureGroup {
                        ForEach(sushi.ingredients) { ingredient in
                            HStack {
                                IngredientCellView(ingredient: ingredient)
                                Spacer()
                            }
                        }
                    } label: {
                        SushiCellView(sushi: sushi)
                    }
                }
                
                Button {
                    meal.sushis = [customizedNigiri.copy()]
                    dismiss()
                } label: {
                    Text("start a new order")
                }
            }
            .padding()
        }
    }
}

struct RecepitView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptView(meal: mealPreview)
    }
}

//
//  Model.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/5/23.
//

import Foundation

//
// MARK: Ingrident
//

enum IngredientType {
    case syari, flesh, vegetable, condiment, nigiri, gunkan, maki
}

class Ingredient: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    let assetName: String?
    let type: IngredientType
    
    @Published var ingredients: [Ingredient]?
    
    init(name: String, assetName: String? = nil, type: IngredientType, ingredients: [Ingredient]? = nil) {
        self.name = name
        self.assetName = assetName
        self.type = type
        self.ingredients = ingredients
    }
}

let syari = Ingredient(name: "Syari", assetName: "sushi_syari", type: .syari)

let syariList = Ingredient(name: "Syari", assetName: nil, type: .syari, ingredients: [syari])

let salmon = Ingredient(name: "Salmon", assetName: "salmon", type: .flesh)

let fleshList = Ingredient(name: "Flesh", assetName: nil, type: .flesh, ingredients: [salmon])

let allIngridentLists = [syariList, fleshList]

//
// MARK: Sushi
//

class Sushi: Ingredient {

    init(name: String, assetName: String? = nil, type: IngredientType, ingredients: [Ingredient]) {
        super.init(name: name, assetName: assetName, type: type)
        self.ingredients = ingredients
    }
    
}

let nigiriCustomized = Sushi(name: "Customzied Nigiri", assetName: nil, type: .nigiri, ingredients: [syari])

let nigiriSalmon = Sushi(name: "Salmon Nigiri", assetName: "sushi_salmon", type: .nigiri, ingredients: [salmon, syari])

//
// MARK: Meal
//

class Meal: ObservableObject {
    @Published var sushis: [Sushi]
    
    init(sushis: [Sushi]) {
        self.sushis = sushis
    }
    
//    addIngredient
}

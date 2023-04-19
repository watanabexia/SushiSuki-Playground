//
//  Model.swift
//  SushiSuki
//
//  Created by Qingyang Xu on 4/5/23.
//

import Foundation

//
// MARK: Source
//

struct Source {
    let name: String
    let kanji: String
    let kana: String
    let romaji: String
    let assetName: String
    let description: String?
    let sourceDescription: String?
}

//
// MARK: Ingrident
//

enum IngredientType: Int, Codable {
    case syari, flesh, other
}

class Ingredient: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    let assetName: String?
    let source: Source?
    let type: IngredientType
    
    init(name: String, assetName: String? = nil, source: Source? = nil, type: IngredientType) {
        self.name = name
        self.assetName = assetName
        self.source = source
        self.type = type
    }
    
    func copy() -> Ingredient {
        let copy = Ingredient(name: self.name, assetName: self.assetName, type: self.type)
        return copy
    }
}

//
// MARK: Sushi
//

enum SushiType {
    case nigiri
}

class Sushi: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var name: String
    let assetName: String?
    let type: SushiType
    
    @Published var ingredients: [Ingredient]

    init(name: String, assetName: String? = nil, type: SushiType, ingredients: [Ingredient]) {
        self.name = name
        self.assetName = assetName
        self.ingredients = ingredients
        self.type = type
        self.ingredients = ingredients
    }
    
    func copy() -> Sushi {
        let copy = Sushi(name: self.name, assetName: self.assetName, type: self.type, ingredients: self.ingredients)
        return copy
    }
}

//
// MARK: Meal
//

class Meal: ObservableObject {
    @Published var sushis: [Sushi]
    
    init(sushis: [Sushi]) {
        self.sushis = sushis
    }
}

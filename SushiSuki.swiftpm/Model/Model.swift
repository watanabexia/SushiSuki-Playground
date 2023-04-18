//
//  Model.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/5/23.
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

//
// MARK: Sushi Database
//

class SushiDB: ObservableObject {
    
    struct IngredientRaw: Codable {
        let name: String
        let assetName: String
        let type: IngredientType
        let sourceName: String
        let kanji: String
        let kana: String
        let romaji: String
        let sourceAssetName: String
    }
    
    var ingredientListDict: [String:[Ingredient]]
    var ingredientDict: [String:Ingredient]
    var sushiDict: [String:Sushi]
    
    init() {
        
        ingredientListDict = [:]
        ingredientDict = [:]
        sushiDict = [:]
        
        if let path = Bundle.main.path(forResource: "ingredients", ofType: ".json") {
            if #available(iOS 16.0, *) {
                do {
                    let data = try Data(contentsOf: URL(filePath: path))
                    let ingredientsRaw = try JSONDecoder().decode([IngredientRaw].self, from: data)
                    
                    var syariList:[Ingredient] = []
                    var fleshList:[Ingredient] = []
                    var otherList:[Ingredient] = []
                    
                    for ingredientRaw in ingredientsRaw {
                        let newIngredient = Ingredient(name: ingredientRaw.name, assetName: ingredientRaw.assetName, source: Source(name: ingredientRaw.sourceName, kanji: ingredientRaw.kanji, kana: ingredientRaw.kana, romaji: ingredientRaw.romaji, assetName: ingredientRaw.sourceAssetName), type: ingredientRaw.type)
                        
                        ingredientDict[newIngredient.name] = newIngredient
                        
                        switch newIngredient.type {
                        case .syari:
                            syariList.append(newIngredient)
                        case .flesh:
                            fleshList.append(newIngredient)
                        case .other:
                            otherList.append(newIngredient)
                        }
                    }
                    
                    ingredientListDict["Flesh"] = fleshList
                    ingredientListDict["Other"] = otherList
                    ingredientListDict["Syari"] = syariList
                    
                    guard let syari = ingredientDict["syari"] else {
                        print("Error: syari is missing")
                        return
                    }
                    
                    for (name, ingredient) in ingredientDict {
                        if ingredient.type != .syari {
                            let newSushiName = "\(name) nigiri"
                            let newSushi = Sushi(name: newSushiName, type: .nigiri, ingredients: [ingredient, syari])
                            sushiDict[newSushiName] = newSushi
                        }
                    }
                    
                } catch {
                    print("SushiDB Initialization failed: \(error)")
                }
                
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

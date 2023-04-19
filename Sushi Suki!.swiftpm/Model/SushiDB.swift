//
//  SushiDB.swift
//  
//
//  Created by Qingyang Xu on 4/18/23.
//

import Foundation

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
        let description: String?
        let sourceDescription: String?
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
                        let newIngredient = Ingredient(name: ingredientRaw.name, assetName: ingredientRaw.assetName, source: Source(name: ingredientRaw.sourceName, kanji: ingredientRaw.kanji, kana: ingredientRaw.kana, romaji: ingredientRaw.romaji, assetName: ingredientRaw.sourceAssetName, description: ingredientRaw.description, sourceDescription: ingredientRaw.sourceDescription), type: ingredientRaw.type)
                        
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
                    
                    ingredientListDict["Flesh"] = fleshList.sorted(by: { ingredient1, ingredient2 in
                        return ingredient1.name < ingredient2.name
                    })
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

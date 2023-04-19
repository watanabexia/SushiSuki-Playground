//
//  PreviewData.swift
//  
//
//  Created by 夏同光 on 4/18/23.
//

var syariPreview = Ingredient(name: "syari", assetName: "sushi_syari", source: rice, type: .syari)

var salmonPreview = Ingredient(name: "salmon", assetName: "salmon", type: .flesh)

var customizedNigiriPreview = Sushi(name: "customized nigiri", type: .nigiri, ingredients: [syariPreview])

var salmonNigiriPreview = Sushi(name: "salmon nigiri", type: .nigiri, ingredients: [salmonPreview, syariPreview])

var mealPreview = Meal(sushis: [customizedNigiriPreview, salmonNigiriPreview])

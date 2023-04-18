//
//  PreviewData.swift
//  
//
//  Created by 夏同光 on 4/18/23.
//

var syariPreview = Ingredient(name: "syari", assetName: "sushi_syari", source: rice, type: .syari)

var mealPreview = Meal(sushis: [Sushi(name: "customized nigiri", type: .nigiri, ingredients: [syari])])

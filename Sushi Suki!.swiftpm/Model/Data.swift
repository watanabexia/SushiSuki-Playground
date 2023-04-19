//
//  Data.swift
//  
//
//  Created by 夏同光 on 4/18/23.
//

var rice = Source(name: "rice", kanji: "米", kana: "ごめ", romaji: "gome", assetName: "food_kome_masu", description: "Syari is typically a specific variety of short-grain Japanese rice that has been cultivated for centuries for its unique texture and flavor. The rice is first rinsed thoroughly to remove any excess starch, then cooked in a specific way that involves adding a mixture of vinegar, sugar, and salt to give it the distinctive flavor and glossy appearance that is characteristic of sushi rice.", sourceDescription: "")

var syari = Ingredient(name: "syari", assetName: "sushi_syari", source: rice, type: .syari)

//
//  AssetCellView.swift
//  SushiSuki
//
//  Created by Qingyang Xu on 4/6/23.
//

import SwiftUI

struct AssetCellView: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        if let assetName = ingredient.assetName {
            Image(assetName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 20)
        }
    }
}

struct AssetCellView_Previews: PreviewProvider {
    static var previews: some View {
        AssetCellView(ingredient: syari)
    }
}

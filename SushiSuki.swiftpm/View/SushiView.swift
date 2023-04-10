//
//  SushiView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/3/23.
//

import SwiftUI
import SpriteKit

@available(iOS 16.0, *)
struct SushiView: View {
    
    var scene: SKScene {
        let scene = SushiScene(meal: meal)
        
        scene.scaleMode = .aspectFill
        return scene
    }
    
    @State var columnVisibility = NavigationSplitViewVisibility.all
    @State var selectedPanel = 0
    @StateObject private var meal = Meal(sushis: [Sushi(name: "Customized Nigiri", assetName: nil, type: .nigiri, ingredients: [syari])])
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            HomeView(columnVisibility: $columnVisibility, selectedPanel: $selectedPanel)
                .navigationTitle("🍣 Sushi Suki!")
        } content: {
            switch selectedPanel {
            case 0:
                Text("")
                .navigationTitle("App Guide")
            case 1:
                VStack {
                    OrderView(meal: meal)
                    IngredientView(meal: meal)
                }
                .navigationTitle("Order")
            default:
                Text("ERROR")
            }
        } detail: {
            switch selectedPanel {
            case 0:
                GuideView()
            case 1:
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            default:
                Text("ERROR")
            }
        }
    }
}

struct SushiView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            SushiView(selectedPanel: 1)
        } else {
            // Fallback on earlier versions
        }
    }
}

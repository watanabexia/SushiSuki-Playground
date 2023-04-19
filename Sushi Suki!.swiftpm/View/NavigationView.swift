//
//  SushiView.swift
//  SushiSuki
//
//  Created by Qingyang Xu on 4/3/23.
//

import SwiftUI
import SpriteKit

@available(iOS 16.0, *)
struct NavigationView: View {
    @EnvironmentObject var sushiDB: SushiDB
    @State var columnVisibility = NavigationSplitViewVisibility.all
    @State var selectedPanel = 0
    @State var page = 1
    @StateObject private var meal = Meal(sushis: [customizedNigiri.copy()])
    
    var scene: SKScene {
        let scene = SushiScene(sushiDB: sushiDB, meal: meal)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            HomeView(columnVisibility: $columnVisibility, selectedPanel: $selectedPanel)
                .navigationTitle("🍣 Sushi Suki!")
        } content: {
            switch selectedPanel {
            case 0:
                VStack {
                    HStack {
                        Button {
                            page = 1
                        } label: {
                            Text("Introduction")
                        }
                        Spacer()
                    }
                    HStack {
                        Button {
                            page = 2
                        } label: {
                            Text("Sushi Customization Guide")
                        }
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Button {
                            page = 3
                        } label: {
                            Text("Credit")
                        }
                        Spacer()
                    }
                    .padding(.top)
                    Spacer()
                }
                .padding()
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
                GuideView(page: $page)
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
    static let sushiDBPreview = SushiDB()
    
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationView(selectedPanel: 1)
                .environmentObject(sushiDBPreview)
        } else {
            // Fallback on earlier versions
        }
    }
}

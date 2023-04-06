//
//  SushiView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/3/23.
//

import SwiftUI
import SpriteKit

struct SushiView: View {
    
    var scene: SKScene {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let scene = SushiScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    @State private var isExpanded = false
    @ObservedObject private var meal = Meal(sushis: [nigiriCustomized, nigiriSalmon])
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                Text("Sidebar")
            } content: {
                VStack {
                    List {
                        ForEach(meal.sushis) { sushi in
                            DisclosureGroup {
                                if let ingredients = sushi.ingredients {
                                    ForEach(ingredients) { ingredient in
                                        IngredientCellView(ingredient: ingredient)
                                    }
                                    .onMove(perform: .none)
                                    .onDelete { indexSet in
                                        sushi.ingredients?.remove(atOffsets: indexSet)
                                    }
                                }
                            } label: {
                                SushiCellView(sushi: sushi)
                            }
                        }
                        .onMove() { from, to in
                            meal.sushis.move(fromOffsets: from, toOffset: to)
                            
                            print("\(from), \(to)")
                        }
                        .onDelete { index in
                            meal.sushis.remove(atOffsets: index)
                        }
                    }
                    .toolbar {
                        EditButton()
                    }
                    
                    Text("Ingredient")
                        .font(.title)
                        .bold()
                    
                    List {
                        ForEach(allIngridentLists) { ingredientList in
                            DisclosureGroup {
                                if let ingredients = ingredientList.ingredients {
                                    ForEach(ingredients) { ingredient in
                                        IngredientManualCellView(ingredient: ingredient)
                                    }
                                }
                            } label: {
                                Text(ingredientList.name)
                            }
                        }
                    }
                }
                .navigationTitle("Order")
                
            } detail: {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct SushiCellView: View {
    
    @State var isEditing = false
    @ObservedObject var sushi: Sushi
    
    var body: some View {
        
        if (isEditing) {
            TextField("Name Placeholder", text: $sushi.name)
                .onSubmit {
                    self.isEditing = false
                }
        } else {
            Text(sushi.name)
                .swipeActions(edge: .leading) {
                    Button {
                        self.isEditing = true
                    } label: {
                        Text("Rename")
                    }
                }
        }
    }
}

struct IngredientCellView: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                if ingredient.assetName != nil {
                    AssetCellView(ingredient: ingredient)
                }
                Text(ingredient.name)
            }
        }
    }
}

struct IngredientManualCellView: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            IngredientCellView(ingredient: ingredient)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(.accentColor)
            }
        }
    }
}

class SushiScene: SKScene {
    
    let syariOke = SKSpriteNode(imageNamed: "sushi_syari_oke")
    let osara = SKSpriteNode(imageNamed: "osara")
    
    var selectedNode: SKSpriteNode?
    var selectedTouchLocation: CGPoint?
    
    override func didMove(to view: SKView) {
        addChild(syariOke)
        
        osara.position = CGPoint(x: frame.midX, y: frame.midY / 2)
        addChild(osara)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        createSyari(location: location)
        
        let touchedNode = self.atPoint(location)
        
        if touchedNode is SKSpriteNode {
            self.selectedNode = touchedNode as? SKSpriteNode
            self.selectedTouchLocation = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let selectedNode = self.selectedNode, let selectedTouchLocation = self.selectedTouchLocation {
            let offset = CGPoint(x: location.x - selectedTouchLocation.x, y: location.y - selectedTouchLocation.y)
            selectedNode.position = CGPoint(x: selectedNode.position.x + offset.x, y: selectedNode.position.y + offset.y)
            
            self.selectedTouchLocation = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.selectedNode = nil
        self.selectedTouchLocation = nil
    }
    
    func createSyari(location: CGPoint) {
        if (syariOke.frame.contains(location)) {
            let syari = SKSpriteNode(imageNamed: "sushi_syari")
            syari.size = CGSize(width: 200, height: 200)
            syari.position = location
            addChild(syari)
        }
    }
}

//class IngridentNode: SKSpriteNode {
//    let type: IngridentType
//
//    init(type: IngridentType) {
//        self.type = type
//        super.init(fileNamed: <#T##String#>)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

struct AssetCellView: View {
    
    let ingredient: Ingredient
    
    var body: some View {
        if let assetName = ingredient.assetName {
            Image(assetName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
        }
    }
}


struct SushiView_Previews: PreviewProvider {
    static var previews: some View {
        SushiView()
    }
}

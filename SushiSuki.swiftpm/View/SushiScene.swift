//
//  SushiScene.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/3/23.
//

import SpriteKit
import SwiftUI

//
// MARK: Global Parameters
//

let unitOffset = 25

//
// MARK: Sushi Scene
//

class SushiScene: SKScene {
    
    @ObservedObject var meal: Meal
    
    var frameCounter = 0
    let unitNewRotarySushi = 270
    
    var mealSushi: Sushi = Sushi(name: "", type: .nigiri, ingredients: [])
    var mealSushiPlateNode: SushiPlateNode = SushiPlateNode(sushiNode: SushiNode(ingredients: []))
    var rotaryOsaraNodes: [SushiPlateNode] = []

    var lastSushiIngredients: [Ingredient]?
    var osaraLocation: CGPoint?
    
//    let syariOke = SKSpriteNode(imageNamed: "sushi_syari_oke")
    
//    var selectedNode: SKSpriteNode?
//    var selectedTouchLocation: CGPoint?
    
    init(meal: Meal) {
        self.meal = meal
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        super.init(size: CGSize(width: screenWidth, height: screenHeight))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let kaiten = SKSpriteNode(imageNamed: "bg_kaitenzushi_empty")
        addChild(kaiten)
        kaiten.position = CGPoint(x: frame.midX, y: frame.maxY - 400)
        kaiten.scale(to: CGSize(width: 1200, height: 676))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        osaraLocation = CGPoint(x: frame.midX, y: frame.midY / 2)
        
        if meal.sushis.isEmpty {
            updateSushi(sushi: Sushi(name: "", type: .nigiri, ingredients: []))
        } else {
            if (isSameSushi(sushi1: meal.sushis[0], sushi2: mealSushi)) {} else {
                updateSushi(sushi: meal.sushis[0])
            }
        }
        
        if (frameCounter == unitNewRotarySushi) {
            frameCounter = 0
        }
        
        if (frameCounter == 0) {
            updateOsara()
        }
        
        moveOsara()
        
        frameCounter += 1
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//
//        createSyari(location: location)
//
//        let touchedNode = self.atPoint(location)
//
//        if touchedNode is SKSpriteNode {
//            self.selectedNode = touchedNode as? SKSpriteNode
//            self.selectedTouchLocation = location
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//
//        if let selectedNode = self.selectedNode, let selectedTouchLocation = self.selectedTouchLocation {
//            let offset = CGPoint(x: location.x - selectedTouchLocation.x, y: location.y - selectedTouchLocation.y)
//            selectedNode.position = CGPoint(x: selectedNode.position.x + offset.x, y: selectedNode.position.y + offset.y)
//
//            self.selectedTouchLocation = location
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.selectedNode = nil
//        self.selectedTouchLocation = nil
//    }
    
//    func createSyari(location: CGPoint) {
//        if (syariOke.frame.contains(location)) {
//            let syari = SKSpriteNode(imageNamed: "sushi_syari")
//            syari.size = CGSize(width: 200, height: 200)
//            syari.position = location
//            addChild(syari)
//        }
//    }
    
    func moveOsara() {
        for rotaryOsaraNode in rotaryOsaraNodes {
            rotaryOsaraNode.position.x = rotaryOsaraNode.position.x - 1.5
        }
    }
    
    func updateOsara() {
        let newSushiNode = SushiNode(ingredients: nigiriSalmon.ingredients!)
        let newOsaraNode = SushiPlateNode(sushiNode: newSushiNode)
        rotaryOsaraNodes.append(newOsaraNode)
        newOsaraNode.position = CGPoint(x: frame.maxX, y: frame.maxY - 230)
        addChild(newOsaraNode)
        
        if rotaryOsaraNodes.count > 5 {
            removeChildren(in: [rotaryOsaraNodes[0]])
            rotaryOsaraNodes.remove(at: 0)
        }
    }
    
    func isSameSushi(sushi1: Sushi, sushi2: Sushi) -> Bool {
        
        guard let ingredient1 = sushi1.ingredients, let ingredient2 = sushi2.ingredients else { return false }
        
        if (ingredient1.count != ingredient2.count) {
            return false
        }
        
        guard ingredient1.count != 0 else { return true }
        
        for i in 0...ingredient1.count - 1 {
            if (ingredient1[i].id != ingredient2[i].id) {
                return false
            }
        }
        
        return true
    }
    
    func updateSushi(sushi: Sushi) {
        
        removeChildren(in: [mealSushiPlateNode])
        
        mealSushi.ingredients = []
        
        for ingredient in sushi.ingredients ?? [] {
            mealSushi.ingredients?.append(ingredient)
        }
        
        mealSushiPlateNode = SushiPlateNode(sushiNode: SushiNode(ingredients: mealSushi.ingredients ?? []))
        
        mealSushiPlateNode.position = CGPoint(x: frame.midX, y: frame.midY - mealSushiPlateNode.size.height / 2)
        
        addChild(mealSushiPlateNode)
    }
}

//
// MARK: Sushi Plate Node
//

class SushiPlateNode: SKSpriteNode {
    
    var sushiNode: SushiNode?
    
    init(sushiNode: SushiNode) {
        
        self.sushiNode = sushiNode
        
        let container = SKNode()
        
        let osaraNode = SKSpriteNode(imageNamed: "osara")
        container.addChild(osaraNode)
        container.addChild(sushiNode)
        sushiNode.position.y = sushiNode.size.height/2 - 83.5
        
        let mergedTexture = SKView().texture(from: container)
        super.init(texture: mergedTexture, color: .clear, size: CGSize(width: 400, height: sushiNode.size.height + 167))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: Sushi Node
//

class SushiNode: SKSpriteNode {
    init(ingredients: [Ingredient]) {
        var ingredientNodes:[IngredientNode] = []
        
        for ingredient in ingredients.reversed() {
            ingredientNodes.append(IngredientNode(imageNamed: ingredient.assetName!))
        }
        
        let container = SKNode()
        
        var counter = 0
        for ingredientNode in ingredientNodes {
            container.addChild(ingredientNode)
            ingredientNode.position.y = CGFloat(counter * unitOffset)
            counter += 1
        }
        
        let mergedTexture = SKView().texture(from: container)
        super.init(texture: mergedTexture, color: .clear, size: CGSize(width: 200, height: 200 + (counter - 1) * unitOffset ))
    }
    
    init(ingredientNodes: [IngredientNode]) {
        
        let container = SKNode()
        
        var counter = 0
        for ingredientNode in ingredientNodes {
            container.addChild(ingredientNode)
            ingredientNode.position.y = CGFloat(counter * unitOffset)
            counter += 1
        }
        
        let mergedTexture = SKView().texture(from: container)
        super.init(texture: mergedTexture, color: .clear, size: CGSize(width: 200, height: 200 + (counter - 1) * unitOffset ))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: Ingredient Node
//

class IngredientNode: SKSpriteNode {
    
    let ingredientSize = CGSize(width: 200, height: 200)
    
    init(imageNamed: String) {
        super.init(texture: SKTexture(imageNamed: imageNamed), color: .clear, size: ingredientSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct SushiScene_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            SushiView(selectedPanel: 1)
        } else {
            // Fallback on earlier versions
        }
    }
}

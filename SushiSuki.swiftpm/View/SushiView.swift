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
    
    @State var selectedPanel = 0
    @StateObject private var meal = Meal(sushis: [Sushi(name: "Customized Nigiri", assetName: nil, type: .nigiri, ingredients: [syari])])
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                HomeView(selectedPanel: $selectedPanel)
                    .navigationTitle("Sushi Suki!")
            } content: {
                switch selectedPanel {
                case 1:
                    VStack {
                        OrderView(meal: meal)
                        IngredientView(meal: meal)
                    }
                    .navigationTitle("Order")
                default:
                    HomeView(selectedPanel: $selectedPanel)
                }
            } detail: {
                switch selectedPanel {
                case 1:
                    SpriteView(scene: scene)
                        .ignoresSafeArea()
                default:
                    GuideView()
                    .navigationTitle("")
                }
            }
        } else {
            // Fallback on earlier versions
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

struct SushiView_Previews: PreviewProvider {
    static var previews: some View {
        SushiView(selectedPanel: 1)
    }
}

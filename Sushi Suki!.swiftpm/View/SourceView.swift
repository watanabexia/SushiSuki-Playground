//
//  SourceView.swift
//  
//
//  Created by Qingyang Xu on 4/18/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct SourceView: View {
    let source: Source
    
    var body: some View {
        ScrollView {
            VStack {
                Image(source.assetName)
                HStack {
                    Text("English")
                    Spacer()
                    Text("Kana/Kanji")
                }
                HStack {
                    Text(source.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("\(source.kana)/\(source.kanji)")
                        .font(.largeTitle)
                        .bold()
                }
                
                if let description = source.description {
                    if description != "" {
                        Text(description)
                            .padding(.top)
                    }
                }
                
                if let sourceDescription = source.sourceDescription {
                    if sourceDescription != "" {
                        HStack {
                            Text("About \(source.name)")
                                .font(.title)
                            .bold()
                            Spacer()
                        }
                        .padding(.vertical)
                        
                        Text(sourceDescription)
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)

        Spacer()
    }
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            SourceView(source: rice)
        } else {
            // Fallback on earlier versions
        }
    }
}

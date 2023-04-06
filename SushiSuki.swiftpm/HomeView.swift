//
//  HomeView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/3/23.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var selectedPanel: Int
    
    var body: some View {
        List {
            Button {
                selectedPanel = 0
            } label: {
                Text("App Guide")
            }
            
            Button {
                selectedPanel = 1
            } label: {
                Text("Start Order")
            }
        }
    }
}

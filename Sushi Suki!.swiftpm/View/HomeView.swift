//
//  HomeView.swift
//  SushiSuki
//
//  Created by Qingyang Xu on 4/3/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    
    @Binding var columnVisibility: NavigationSplitViewVisibility
    @Binding var selectedPanel: Int
    
    var body: some View {
        List {
            Button {
                selectedPanel = 0
                columnVisibility = NavigationSplitViewVisibility.doubleColumn
            } label: {
                Text("App Guide")
            }

            Button {
                selectedPanel = 1
                columnVisibility = NavigationSplitViewVisibility.doubleColumn
            } label: {
                Text("Start Order")
            }
        }
    }
}

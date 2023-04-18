//
//  GuideView.swift
//  SushiSuki
//
//  Created by 夏同光 on 4/3/23.
//

import SwiftUI

struct GuideView: View {
    @State var page: Int = 1
    
    var body: some View {
        TabView(selection: $page) {
            ScrollView {
                VStack {
                    Text("Sushi Suki")
                        .font(.largeTitle.bold())
                    Text("Resource")
                        .font(.title2.bold())
                    Text("Sushi Images: www.irasutoya.com")
                }
            }
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}

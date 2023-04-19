//
//  GuideView.swift
//  SushiSuki
//
//  Created by Qingyang Xu on 4/3/23.
//

import SwiftUI

struct GuideView: View {
    @Binding var page: Int
    
    var body: some View {
        TabView(selection: $page) {
            ScrollView {
                VStack {
                    HStack {
                        Text("Welcome to Sushi Suki!")
                            .font(.largeTitle)
                        .bold()
                        Spacer()
                    }
                    HStack {
                        Text("a love letter to 🍣 lovers")
                            .font(.title2)
                        Spacer()
                    }
                    HStack {
                        Text("what is this?")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical)
                    HStack {
                        Text("Sushi Suki! is a sushi ordering app that helps you preapre your next meal with sushis.")
                        Spacer()
                    }
                    HStack {
                        Image("Guide-0")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        Text("Feeling lucky today? Enjoy the chef's choice by taking the sushi from the conveyor belt!")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Image("Guide-1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        Text("Want to do-it-yourself? Customize your unique sushi with the ingredients however you want!")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Image("Guide-2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        HStack {
                            Text("New to sushi? Learn about the ingredients by tapping \(Image(systemName: "info.circle"))")
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Image("Guide-3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        Text("Done with ordering? Use one tap to generate your receipt!")
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .tag(1)
            ScrollView {
                VStack {
                    HStack {
                        Text("Sushi Customization Guide")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical)
                    HStack {
                        Image("Guide-4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        
                        VStack {
                            HStack {
                                Text("Drag the sushi to the top to customize it")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            HStack {
                                Text("Tap \(Image(systemName: "plus.circle")) to add a new sushi")
                                Spacer()
                            }
                            .padding(.top)
                            HStack {
                                Text("Tap the sushi name to see its ingredients")
                                Spacer()
                            }
                            .padding(.top)
                            HStack {
                                Text("Right swipe to rename the sushi, enter to save the changes")
                                Spacer()
                            }
                            .padding(.top)
                            HStack {
                                Text("Left swipe to delete the sushi/ingredient")
                                Spacer()
                            }
                            .padding(.top)
                            HStack {
                                Text("Tap CLEAR ALL to delete all sushis")
                                Spacer()
                            }
                            .padding(.top)
                            HStack {
                                Text("Tap Receipt to generate the receipt")
                                Spacer()
                            }
                            .padding(.top)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    HStack {
                        Image("Guide-5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300)
                            .cornerRadius(10)
                        
                        VStack {
                            HStack {
                                Text("Tap the ingredient to add it to the first sushi in the order list")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                            }
                            HStack {
                                Text("Tap \(Image(systemName: "info.circle")) learn more about the ingredient")
                                Spacer()
                            }
                            .padding(.top)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .tag(2)
            ScrollView {
                VStack {
                    HStack {
                        Text("Future Plan")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    VStack {
                        HStack {
                            Text("A sushi index to store, manage and rate the sushis, including the ones you make")
                            Spacer()
                        }
                        .padding(.top, 1)
                        HStack {
                            Text("An order index to store the previous orders, so that you can make the same order again")
                            Spacer()
                        }
                        .padding(.top, 1)
                        HStack {
                            Text("Adding support for more sushis, including everyone's favourite gunkan and maki sushis")
                            Spacer()
                        }
                        .padding(.top, 1)
                    }
                    HStack {
                        Text("Powered by")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Text("SwiftUI")
                        Text("SpriteKit")
                        Spacer()
                    }
                    .font(.title2)
                    .padding(.top)
                    HStack {
                        Text("Credit")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Text("Ingredient/fish images: [www.irasutoya.com](https://www.irasutoya.com)")
                        Spacer()
                    }
                    .padding(.top)
                }
            }
            .tag(3)
        }
        .padding()
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct GuideView_Previews: PreviewProvider {
    @State static var pagePreview = 0
    
    static var previews: some View {
        GuideView(page: $pagePreview)
    }
}

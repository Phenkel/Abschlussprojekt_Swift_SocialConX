//
//  TabBar.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            FeedView()
                .tabItem {
                    Image(systemName: selected == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selected == 0 ? .fill : .none)
                    Text("Xpressions")
                }
                .onAppear { selected = 0 }
                .tag(0)
                .badge(99)
            
            ExploreView()
                .tabItem {
                    Image(systemName: selected == 1 ? "circle.hexagonpath.fill" : "circle.hexagonpath")
                        .environment(\.symbolVariants, selected == 1 ? .fill : .none)
                    Text("Xplore")
                }
                .onAppear { selected = 1 }
                .tag(1)
            
            ChatView()
                .tabItem {
                    Image(systemName: selected == 2 ? "message.fill" : "message")
                        .environment(\.symbolVariants, selected == 2 ? .fill : .none)
                    Text("Xversations")
                }
                .onAppear { selected = 2 }
                .tag(2)
                .badge(99)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selected == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selected == 3 ? .fill : .none)
                    Text("Xtivity")
                }
                .onAppear { selected = 3 }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selected == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selected == 4 ? .fill : .none)
                    Text("Xdentity")
                }
                .onAppear { selected = 4 }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
}

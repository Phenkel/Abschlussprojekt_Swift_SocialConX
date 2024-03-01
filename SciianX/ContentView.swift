//
//  TabBar.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

enum PageSelection: String {
    case feed, explore, chat, activity, profile
}

struct ContentView: View {
    
    @State private var selected: PageSelection = .feed
    
    var body: some View {
        TabView(selection: $selected) {
            Group {
                FeedView()
                    .tabItem {
                        Image(systemName: selected == .feed ? "house.fill" : "house")
                            .environment(\.symbolVariants, selected == .feed ? .fill : .none)
                        Text("Xpressions")
                    }
                    .tag(PageSelection.feed)
                    .badge(99)
                
                ExploreView()
                    .tabItem {
                        Image(systemName: selected == .explore ? "circle.hexagonpath.fill" : "circle.hexagonpath")
                            .environment(\.symbolVariants, selected == .explore ? .fill : .none)
                        Text("Xplore")
                    }
                    .tag(PageSelection.explore)
                
                ChatView()
                    .tabItem {
                        Image(systemName: selected == .chat ? "message.fill" : "message")
                            .environment(\.symbolVariants, selected == .chat ? .fill : .none)
                        Text("Xversations")
                    }
                    .tag(PageSelection.chat)
                    .badge(99)
                
                ActivityView()
                    .tabItem {
                        Image(systemName: selected == .activity ? "heart.fill" : "heart")
                            .environment(\.symbolVariants, selected == .activity ? .fill : .none)
                        Text("Xtivity")
                    }
                    .tag(PageSelection.activity)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: selected == .profile ? "person.fill" : "person")
                            .environment(\.symbolVariants, selected == .profile ? .fill : .none)
                        Text("Xdentity")
                    }
                    .tag(PageSelection.profile)
            }
        }
    }
}

#Preview {
    ContentView()
}

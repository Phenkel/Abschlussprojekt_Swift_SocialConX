import SwiftUI

enum PageSelection: String {
    case feed, explore, chat, activity, profile
}

struct ContentView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var feedsViewModel: FeedsViewModel
    
    @State private var selected: PageSelection = .feed
    
    init(_ authenticationViewModel: AuthenticationViewModel) {
        self._feedsViewModel = StateObject(wrappedValue: FeedsViewModel(authenticationViewModel.user))
    }
    
    var body: some View {
        TabView(selection: $selected) {
            FeedView()
                .tabItem {
                    Image(systemName: selected == .feed ? "house.fill" : "house")
                        .environment(\.symbolVariants, selected == .feed ? .fill : .none)
                    Text("Xpressions")
                }
                .tag(PageSelection.feed)
                .environmentObject(self.feedsViewModel)
            
            ExploreView()
                .tabItem {
                    Image(systemName: selected == .explore ? "circle.hexagonpath.fill" : "circle.hexagonpath")
                        .environment(\.symbolVariants, selected == .explore ? .fill : .none)
                    Text("Xplore")
                }
                .tag(PageSelection.explore)
            
            ChatOverViewView()
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
                .environmentObject(self.feedsViewModel)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selected == .profile ? "person.fill" : "person")
                        .environment(\.symbolVariants, selected == .profile ? .fill : .none)
                    Text("Xdentity")
                }
                .tag(PageSelection.profile)
                .environmentObject(self.feedsViewModel)
        }
    }
}

//
//  ExploreView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var search = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(0...25, id: \.self) { user in
                            ProfilePreviewRow()
                        }
                    }
                }
                .navigationTitle("ConXplore")
                .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $search, prompt: "Search_Key")
            }
        }
    }
}

#Preview {
    ExploreView()
}

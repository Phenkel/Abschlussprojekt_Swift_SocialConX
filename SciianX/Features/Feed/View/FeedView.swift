//
//  FeedView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(0...25, id: \.self) { post in
                        PostView()
                    }
                }
            }
            .refreshable {
                // Refresh Action
            }
            .navigationTitle("ConXpressions")
            .navigationBarTitleDisplayMode(.large)
        }
        .toolbar {
            // New Post Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus.app")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeedView()
    }
}

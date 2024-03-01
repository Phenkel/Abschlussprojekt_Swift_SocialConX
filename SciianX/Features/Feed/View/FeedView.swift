//
//  FeedView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct FeedView: View {
    
    @State private var showAll = true
    @State private var showCreatePost = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                ScrollView(showsIndicators: false) {
                    Picker(selection: $showAll.animation(), label: Text("Feed_Filter")) {
                        Text("ShowAll_Key")
                            .tag(true)
                        Text("ShowFollowed_Key")
                            .tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if showAll {
                        LazyVStack {
                            ForEach(0...25, id: \.self) { post in
                                PostRow()
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        LazyVStack {
                            ForEach(0...25, id: \.self) { post in
                                PostRow()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                //.padding(.top)
            }
            .sheet(isPresented: $showCreatePost, content: {
                CreatePostView()
                    .presentationDetents([.medium, .large])
            })
            .refreshable {
                // Refresh Action
            }
            .navigationTitle("ConXpressions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.showCreatePost = true
                    }, label: {
                        Image(systemName: "plus.app")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Text("Translated Texts")
                            .font(.caption2)
                    })
                }
            }
        }
    }
}

#Preview {
    FeedView()
}

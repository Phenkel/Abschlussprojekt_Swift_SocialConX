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
            ScrollView {
                LazyVStack {
                    ForEach(0...25, id: \.self) { user in
                        HStack {
                            Image("testPic")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(Circle())
                                .shadow(color: .blue, radius: 5)
                            
                            VStack {
                                Text("Username")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                
                                Text("Real Name")
                                    .font(.footnote)
                                    .fontWeight(.thin)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Text("Follow")
                                    .fontWeight(.semibold)
                                    .frame(width: 80, height: 40)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.blue, lineWidth: 1)
                                    }
                            })
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        
                        DividerSingleX()
                    }
                }
            }
            .navigationTitle("ConXplore")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $search, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}

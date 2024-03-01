//
//  PostView.swift
//  SciianX
//
//  Created by Philipp Henkel on 11.01.24.
//

import SwiftUI

struct PostRow: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 16) {
                // Profile Picture
                ProfilePictureSmallView()
                
                VStack() {
                    HStack {
                        // Username
                        Text("Username")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    // Post Content
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi.")
                        .font(.footnote)
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 16) {
                        // Like Button
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "heart")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                        })
                        
                        // Comment Button
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "text.bubble")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                        })
                        
                        // Repost Button
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "arrow.3.trianglepath")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                        })
                        
                        // Send Button
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "envelope")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                        })
                        
                        Spacer()
                        
                        // Time Stamp
                        Text("Time")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PostRow()
}

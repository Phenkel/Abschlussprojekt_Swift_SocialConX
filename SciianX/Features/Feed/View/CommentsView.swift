//
//  CommentsView.swift
//  SciianX
//
//  Created by Philipp Henkel on 13.03.24.
//

import SwiftUI

struct CommentsView: View {
    
    var comments: [CommentViewModel]
    
    @State private var comment = ""
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundImage()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        HStack(alignment: .top) {
                            ProfilePictureSmall()
                            
                            VStack(alignment: .leading) {
                                Text("Username")
                                    .fontWeight(.semibold)
                                
                                TextField("Write your thoughts", text: $comment, axis: .vertical)
                                    .fontWeight(.thin)
                            }
                            .font(.footnote)
                            
                            Spacer()
                            
                            if !comment.isEmpty {
                                Button(action: {
                                    self.comment = ""
                                }, label: {
                                    Text("X")
                                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                                        .font(.system(size: 20))
                                })
                            }
                        }
                        
                        Divider()
                                        
                        LazyVStack {
                            ForEach(0...25, id: \.self) { comment in
                                CommentRow(commentViewModel: dummyCommentViewModel)
                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Comments")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                self.dismiss()
                            }, label: {
                                Text("Cancel")
                            })
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                // MARK: POST ACTION
                                self.dismiss()
                            }, label: {
                                Text("Post")
                            })
                            .disabled(self.comment.isEmpty)
                        }
                }
                }
            }
        }
    }
}

#Preview {
    CommentsView(comments: [])
}

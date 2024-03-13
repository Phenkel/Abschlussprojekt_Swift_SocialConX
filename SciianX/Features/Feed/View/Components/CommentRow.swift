//
//  CommentRow.swift
//  SciianX
//
//  Created by Philipp Henkel on 13.03.24.
//

import SwiftUI

struct CommentRow: View {
    
    @StateObject var commentViewModel: CommentViewModel
    
    @State private var translationActive: Bool = false
    private var textIsTranslated: Bool {
        commentViewModel.translatedText != nil
    }
    
    var body: some View {
        VStack() {
            HStack(alignment: .top, spacing: 16) {
                ProfilePictureSmall()
                
                VStack(spacing: 8) {
                    HStack {
                        Text(self.commentViewModel.creator.realName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: {
                            // MARK: OPEN CHAT
                        }, label: {
                            Image(systemName: "envelope")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                        })
                    }
                    Text(self.commentViewModel.text)
                        .font(.footnote)
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                self.translationActive.toggle()
                            }, label: {
                                Text(self.textIsTranslated ? (self.translationActive ? "Show original" : "Translate") : "No Translation")
                            })
                            .disabled(!self.textIsTranslated)
                            
                            Text(self.commentViewModel.createdAtString)
                                .fontWeight(.ultraLight)
                        }
                        .font(.footnote)
                    }
                }
            }
            
            Divider()
        }
        .onAppear {
            // MARK: Kommentar um Requests zu sparen
            //self.commentViewModel.translateText()
        }
        .onChange(of: self.textIsTranslated) {
            if self.textIsTranslated {
                self.translationActive = true
            } else {
                self.translationActive = false
            }
        }
    }
}

#Preview {
    CommentRow(commentViewModel: dummyCommentViewModel)
}

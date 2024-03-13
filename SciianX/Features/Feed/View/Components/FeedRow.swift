import SwiftUI

struct FeedRow: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @StateObject var feedViewModel: FeedViewModel
    
    @State private var showComments = false
    @State private var translationActive: Bool = false
    
    private var textIsTranslated: Bool {
        feedViewModel.translatedText != nil
    }
    
    var body: some View {
        VStack() {
            HStack(alignment: .top, spacing: 16) {
                ProfilePictureSmall()
                
                VStack(spacing: 8) {
                    HStack {
                        Text(self.feedViewModel.creator.realName)
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "envelope")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                        })
                    }
                    Text((!self.translationActive ? self.feedViewModel.text : self.feedViewModel.translatedText) ?? "")
                        .font(.footnote)
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack {
                            Button(action: {
                                self.feedViewModel.likeFeed()
                            }, label: {
                                Image(systemName: "heart")
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                            })
                            Text(String(self.feedViewModel.likes.count))
                                .font(.footnote)
                                .fontWeight(.ultraLight)
                        }
                        
                        VStack {
                            Button(action: {
                                self.showComments = true
                            }, label: {
                                Image(systemName: "text.bubble")
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                            })
                            Text(String(self.feedViewModel.comments.count))
                                .font(.footnote)
                                .fontWeight(.ultraLight)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                self.translationActive.toggle()
                            }, label: {
                                Text(self.textIsTranslated ? (self.translationActive ? "Show original" : "Translate") : "No Translation")
                            })
                            .disabled(!self.textIsTranslated)
                            
                            Text(self.feedViewModel.createdAtString)
                                .fontWeight(.ultraLight)
                        }
                        .font(.footnote)
                    }
                }
            }
            
            Divider()
        }
        .sheet(isPresented: $showComments, content: {
            CommentsView(comments: self.feedViewModel.comments)
                .presentationDetents([.medium, .large])
        })
        .onAppear {
            self.feedViewModel.translateText()
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

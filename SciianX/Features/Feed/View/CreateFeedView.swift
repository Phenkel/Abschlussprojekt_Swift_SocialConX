import SwiftUI

struct CreateFeedView: View {
    
    @EnvironmentObject private var feedsViewModel: FeedsViewModel
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    @State private var post = ""
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    ProfilePictureSmall()
                    
                    VStack(alignment: .leading) {
                        Text("Username")
                            .fontWeight(.semibold)
                        
                        TextField("Write your thoughts", text: $post, axis: .vertical)
                            .fontWeight(.thin)
                    }
                    .font(.footnote)
                    
                    Spacer()
                    
                    if !post.isEmpty {
                        Button(action: {
                            self.post = ""
                        }, label: {
                            Text("X")
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                                .font(.system(size: 20))
                        })
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
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
                        if let user = self.authenticationViewModel.user {
                            self.feedsViewModel.createFeed(self.post, withUser: user)
                        }
                        self.dismiss()
                    }, label: {
                        Text("Post")
                    })
                    .disabled(self.post.isEmpty)
                }
            }
        }
    }
}

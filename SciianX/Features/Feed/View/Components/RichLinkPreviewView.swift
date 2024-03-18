//
//  RichLinkPreviewView.swift
//  SciianX
//
//  Created by Philipp Henkel on 15.03.24.
//

import SwiftUI
import AVKit

struct RichLinkPreviewView: View {
    
    @StateObject var richPreviewViewModel: RichPreviewViewModel
    
    @State private var player = AVPlayer()
    @State private var showWebView: Bool = false
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.richPreviewViewModel.number + " " + (self.richPreviewViewModel.title ?? ""))
                .font(.caption)
                .fontWeight(.bold)
            
            if let videoUrl = self.richPreviewViewModel.videoUrl {
                VideoPlayer(player: self.player)
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .onAppear {
                        self.player = AVPlayer(url: videoUrl)
                    }
            } else if let image = self.richPreviewViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
            }
            
            if let description = self.richPreviewViewModel.description {
                Text(description)
                    .font(.caption)
                    .fontWeight(.thin)
            }
            
            Button(action: {
                self.showWebView = true
            }, label: {
                if let icon = self.richPreviewViewModel.icon {
                    Image(uiImage: icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                }
                
                if let host = self.richPreviewViewModel.host {
                    Text(host)
                } else {
                    Text("See more")
                }
            })
            
            Divider()
        }
        .sheet(isPresented: $showWebView, content: {
            NavigationStack {
                WebView(url: self.richPreviewViewModel.url)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                self.showWebView = false
                            }, label: {
                                Image(systemName: "arrowshape.backward.fill")
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                                
                                Text("Close")
                            })
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Link(destination: self.richPreviewViewModel.url, label: {
                                Text("Open in Browser")
                                
                                Image(systemName: "globe")
                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing))
                            })
                        }
                }
            }
        })
    }
}

#Preview {
    guard let url = URL(string: "https://swiftpackageindex.com/nmdias/FeedKit") else {
        return ProfileView()
    }
    
    return RichLinkPreviewView(richPreviewViewModel: RichPreviewViewModel(("(1)", url)))
}

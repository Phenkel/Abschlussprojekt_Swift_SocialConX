//
//  FeedViewModel.swift
//  SciianX
//
//  Created by Philipp Henkel on 12.03.24.
//

import Foundation

class FeedViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var creator: UserProfile
    @Published private(set) var text: String
    @Published private(set) var translatedText: String?
    @Published private(set) var likes: [UserProfile]
    @Published private(set) var comments: [CommentViewModel]
    @Published private(set) var createdAt: Date
    @Published private(set) var createdAtString: String
    @Published private(set) var updatedAt: Date
    @Published private(set) var activeUsers: [UserProfile]
    @Published private(set) var richPreviews: [RichPreviewViewModel] = []
    
    let id: String?
    
    private let user: UserProfile
    private let originalText: String
    private let translationRepository = TranslationRepository.shared
    private let feedRepository = FirebaseFeedRepository.shared
    
    init(_ feed: Feed, withUser user: UserProfile) {
        self.creator = feed.creator
        self.text = feed.text
        self.likes = feed.likes
        self.comments = feed.comments.compactMap { CommentViewModel($0) }
        self.createdAt = feed.createdAt
        self.createdAtString = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy HH:mm"
            return formatter.string(from: feed.createdAt)
        }()
        self.updatedAt = feed.updatedAt
        self.activeUsers = feed.activeUsers
        self.id = feed.id
        self.user = user
        self.originalText = feed.text
        
        let (text, urlSets) = filterAndReplaceURs(self.text)
        self.text = text
        self.urlSetsToRichPreviews(urlSet: urlSets)
    }
    
    @MainActor
    func translateText() {
        Task {
            do {
                let translation = try await translationRepository.translateText(self.text)
                
                let (text, _) = self.filterAndReplaceURs(translation.data.translatedText)
                
                self.translatedText = text
            } catch {
                print("Failed translating text: \(error)")
            }
        }
    }
    
    func likeFeed() {
        feedRepository.likeFeed(withUser: user, feed: self.asFeed())
    }
    
    func createComment(_ text: String) {
        self.feedRepository.createComment(text, withUser: user, feed: self.asFeed())
    }
    
    private func asFeed() -> Feed {
        return Feed(
            id: self.id,
            creator: self.creator,
            text: self.originalText,
            likes: self.likes,
            comments: self.comments.compactMap {
                $0.asComment()
            },
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            activeUsers: self.activeUsers
        )
    }
    
    private func filterAndReplaceURs(_ text: String) -> (String, [(number: String, url: URL)]) {
        var replacedText = text
        var urls: [(String, URL)] = []
        var counter = 1
        
        let scanner = Scanner(string: text)
        scanner.charactersToBeSkipped = NSCharacterSet.whitespacesAndNewlines
        
        while !scanner.isAtEnd {
            var urlString: NSString?
            scanner.scanCharacters(from: NSCharacterSet.urlQueryAllowed, into: &urlString)
            
            if let urlString {
                if let url = URL(string: urlString as String) {
                    let replacement = "(\(counter))"
                    replacedText = replacedText.replacingOccurrences(of: urlString as String, with: replacement)
                    
                    urls.append((replacement, url))
                    
                    counter += 1
                }
            }
        }
        
        return (replacedText, urls)
    }
    
    private func urlSetsToRichPreviews(urlSet: [(number: String, url: URL)]) {
        Task {
            await MainActor.run {
                self.richPreviews = urlSet.compactMap {
                    RichPreviewViewModel($0)
                }
            }
        }
    }
}

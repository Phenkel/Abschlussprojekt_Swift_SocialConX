//
//  MailCheckRepository.swift
//  SciianX
//
//  Created by Philipp Henkel on 01.03.24.
//

import Foundation

class MailCheckRepository {
    
    static let shared = MailCheckRepository()
    private let apiKey = "c2f07c81a1msha6f1543ac98dd5fp1f3425jsnaa46c190a646"
    
    private init() {}
    
    func checkEmail(_ mail: String) async throws -> MailCheck {
        guard let url = URL(string: "https://mailcheck.p.rapidapi.com/\(mail)") else {
            throw HTTPError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(self.apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let response = try await URLSession.shared.data(for: urlRequest)
        
        let data = try checkResponse(response)
        
        return try JSONDecoder().decode(MailCheck.self, from: data)
    }
}

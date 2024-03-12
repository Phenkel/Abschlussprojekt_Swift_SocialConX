//
//  MailCheckRepository.swift
//  SciianX
//
//  Created by Philipp Henkel on 01.03.24.
//

import Foundation

class MailCheckRepository {
    
    static let shared = MailCheckRepository()
    
    private init() {}
    
    func checkEmail(_ mail: String) async throws -> MailCheck {
        guard let url = URL(string: "https://mailcheck.p.rapidapi.com/\(mail)") else {
            throw HTTPError.invalidUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(ApiManager.xRapidApiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        
        let response = try await URLSession.shared.data(for: urlRequest)
        
        let data = try checkApiResponse(response)
        
        return try JSONDecoder().decode(MailCheck.self, from: data)
    }
}

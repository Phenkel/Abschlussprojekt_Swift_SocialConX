//
//  MailCheck.swift
//  SciianX
//
//  Created by Philipp Henkel on 01.03.24.
//

import Foundation

struct MailCheck: Codable {
    let valid, block, disposable, emailForwarder: Bool
    let domain, text: String
}

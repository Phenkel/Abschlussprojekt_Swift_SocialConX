//
//  CheckApiResponse.swift
//  SciianX
//
//  Created by Philipp Henkel on 01.03.24.
//

import Foundation

func checkResponse(_ response: (data: Data, response: URLResponse)) throws -> Data {
    guard let httpResponse = response.response as? HTTPURLResponse else {
        return response.data
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
        // Der Statuscode liegt im erfolgreichen Bereich (200-299), daher werden die Antwortdaten zurückgegeben.
        return response.data
    case 400:
        // Der Statuscode 400 deutet auf eine fehlerhafte Anfrage hin.
        throw HTTPError.badRequest
    case 401:
        // Der Statuscode 401 zeigt an, dass die Anfrage nicht authentifiziert ist.
        throw HTTPError.unauthorized
    case 402:
        // Der Statuscode 402 gibt an, dass eine Zahlung erforderlich ist.
        throw HTTPError.paymentRequired
    case 403:
        // Der Statuscode 403 zeigt an, dass der Zugriff auf die angeforderten Ressourcen verboten ist.
        throw HTTPError.forbidden
    case 404:
        // Der Statuscode 404 bedeutet, dass die angeforderte Ressource nicht gefunden wurde.
        throw HTTPError.notFound
    case 413:
        // Der Statuscode 413 gibt an, dass die Anfrageentität zu groß ist.
        throw HTTPError.requestEntityTooLarge
    case 422:
        // Der Statuscode 422 zeigt an, dass die Server die Anfrage entgegengenommen hat, aber sie unverarbeitbar ist.
        throw HTTPError.unprocessableEntity
    default:
        // Ein unerwarteter Statuscode wird durch den `http`-Fehlerfall des `enum NetworkError` repräsentiert.
        throw HTTPError.http(httpResponse.statusCode)
    }
}

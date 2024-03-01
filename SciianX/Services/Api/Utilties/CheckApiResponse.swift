//
//  CheckApiResponse.swift
//  SciianX
//
//  Created by Philipp Henkel on 01.03.24.
//

import Foundation

/// Überprüft die HTTP-Antwort und wirft einen entsprechenden Fehler basierend auf dem Statuscode.
///
/// - Parameter response: Das Tupel, das die Antwortdaten und die URL-Antwort enthält.
/// - Returns: Die Antwortdaten, wenn der Statuscode erfolgreich ist.
/// - Throws: Einen Fehler des `enum NetworkError`, wenn ein unerwarteter Statuscode auftritt.
func checkResponse(_ response: (data: Data, response: URLResponse)) throws -> Data {
    // Überprüfen, ob die Antwort eine HTTP-Antwort ist
    guard let httpResponse = response.response as? HTTPURLResponse else {
        // Rückgabedaten ohne Änderung, wenn keine HTTP-Antwort vorhanden
        return response.data
    }
    
    // Überprüfen des Statuscodes und entsprechendes Werfen des Fehlers
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

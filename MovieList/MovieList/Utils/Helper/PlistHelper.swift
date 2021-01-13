//
//  PlistHelper.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import Foundation

enum ConfigPlistKey: String {
    case apiKey
}

class PlistHelper {
    static let shared = PlistHelper()

    func getString(forKey key: ConfigPlistKey) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
    }
}

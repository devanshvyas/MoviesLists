//
//  BaseModel.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import Foundation

class BaseModel: Codable {
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    var results: [ListingData]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

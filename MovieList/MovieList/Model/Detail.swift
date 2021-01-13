//
//  Detail.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import Foundation

class Details: Codable {
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var budget: Double?
    var releaseDate: String?
    var genres: [Genres]?
    var runtime: Double?
    var productionCompanies: [ProductionCompanies]?
    var spokenLanguages: [Languages]?
    var title: String?
    var tagline: String?
    var revenue: Double?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case budget
        case releaseDate
        case genres
        case runtime
        case productionCompanies = "production_companies"
        case spokenLanguages = "spoken_languages"
        case title
        case tagline
        case revenue
    }
}

class Genres: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

class ProductionCompanies: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

class Languages: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

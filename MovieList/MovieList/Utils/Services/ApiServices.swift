//
//  ApiServices.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

class ApiServices {
    static let shared = ApiServices()
    var isShowingIndicator = false
    
    var listingUrl = "https://api.themoviedb.org/3/discover/movie?api_key="
    var detailUrl = "https://api.themoviedb.org/3/movie/%d?api_key="
    var posterUrl = "https://image.tmdb.org/t/p/w200"
    var coverUrl = "https://image.tmdb.org/t/p/w500"
    
    var apiKey = PlistHelper.shared.getString(forKey: .apiKey) ?? ""
    
    func getMovieLists(page: Int = 1, complete: @escaping ((BaseModel?) -> ())) {
        guard let url = URL(string: listingUrl + apiKey + "&page=\(page)") else { return }
        let urlReq = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            self.isShowingIndicator = false
            if let _ = error {
                complete(nil)
            } else if let modelData = data  {
                do {
                    let baseModel = try JSONDecoder().decode(BaseModel.self, from: modelData)
                    complete(baseModel)
                } catch (let error) {
                    complete(nil)
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    func getMovieDetail(movieId: Int, complete: @escaping ((Details?) -> ())) {
        guard let url = URL(string: detailUrl.replacingOccurrences(of: "%d", with: String(movieId)) + apiKey) else { return }
        let urlReq = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            self.isShowingIndicator = false
            if let _ = error {
                complete(nil)
            } else if let modelData = data  {
                do {
                    let details = try JSONDecoder().decode(Details.self, from: modelData)
                    complete(details)
                } catch (let error) {
                    complete(nil)
                    print(error)
                }
            }
            
        }
        task.resume()
    }
}

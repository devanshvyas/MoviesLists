//
//  DetailViewController.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

enum DetailCells: String {
    case imageCell
    case overview = "Overview"
    case genres = "Genres"
    case duration = "Duration"
    case releaseDate = "Release Date"
    case companies = "Production Companies"
    case budget = "Production Budget"
    case revenue = "Revenue"
    case languages = "Languages"
}

class DetailViewController: UIViewController {
    
    var movieId: Int?
    var movieTitle: String?
    var movieDetails: Details? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var cells: [DetailCells] = [.imageCell, .overview, .genres, .duration, .releaseDate, .companies, .budget, .revenue, .languages]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Colors.defaultBG
        title = movieTitle
        tableView.registerCell(id: String(describing: ImagesCell.self))
        tableView.registerCell(id: String(describing: DetailsCell.self))
        apiCalling()
    }
    
    func apiCalling() {
        guard let id = movieId else { return }
        ApiServices.shared.getMovieDetail(movieId: id) { (details, error) in
            if let err = error as NSError?, err.domain == NSURLErrorDomain, err.code == NSURLErrorNotConnectedToInternet {
                let alert = UIAlertController(title: "Network error", message: "Unable to contact the server", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if let movieDetail = details {
                self.movieDetails = movieDetail
            }
        }
    }
}


extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        switch cell {
        case .imageCell:
            let imageCell: ImagesCell = tableView.dequeue(ImagesCell.self, for: indexPath)
            imageCell.details = movieDetails
            return imageCell
        default:
            let detailCell: DetailsCell = tableView.dequeue(DetailsCell.self, for: indexPath)
            detailCell.titleText = cell.rawValue
            switch cell {
            case .overview:
                detailCell.detailText = movieDetails?.overview
                
            case .genres:
                detailCell.detailText = movieDetails?.genres?.reduce("", { (res, gen) in
                    return res + (gen.name ?? "") + ","
                })
                
            case .duration:
                detailCell.detailText = String(format: "%.0f", movieDetails?.runtime ?? "") + " Minutes"
                
            case .releaseDate:
                detailCell.detailText = movieDetails?.releaseDate
                
            case .companies:
                detailCell.detailText = movieDetails?.productionCompanies?.reduce("", { (res, comp) in
                    return res + (comp.name ?? "") + ", "
                })
                
            case .budget:
                detailCell.detailText = "$"+String(format: "%.2f", movieDetails?.budget ?? "")
                
            case .revenue:
                detailCell.detailText = "$"+String(format: "%.2f", movieDetails?.revenue ?? "")
                
            case .languages:
                detailCell.detailText = movieDetails?.spokenLanguages?.reduce("", { (res, comp) in
                    return res + (comp.name ?? "") + ", "
                })
                
            default:
                detailCell.detailText = ""
            }
            return detailCell
        }
    }
}

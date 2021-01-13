//
//  ViewController.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listingData: [ListingData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var baseModel: BaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        tableView.registerCell(id: String(describing: ListingTableViewCell.self))
        tableView.backgroundColor = Colors.defaultBG
        navigationController?.navigationBar.backgroundColor = Colors.navigationBG
        apiCalling()
    }
    
    func apiCalling(page: Int = 1) {
        ApiServices.shared.getMovieLists(page: page) { (baseModel, error) in
            if let err = error as NSError?, err.domain == NSURLErrorDomain, err.code == NSURLErrorNotConnectedToInternet {
                let alert = UIAlertController(title: "Network error", message: "Unable to contact the server", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if let model = baseModel {
                self.baseModel = model
                self.listingData.append(contentsOf: baseModel?.results ?? [])
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListingTableViewCell = tableView.dequeue(ListingTableViewCell.self, for: indexPath)
        cell.listingData = self.listingData[indexPath.row]
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC: DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiate()
        detailVC.movieId = listingData[indexPath.row].id
        detailVC.movieTitle = listingData[indexPath.row].title
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MoviesViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height,
           baseModel?.page ?? 0 < baseModel?.totalPages ?? 0 {
            apiCalling(page: (baseModel?.page ?? 0) + 1)
        }
    }
}

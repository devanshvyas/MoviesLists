//
//  ListingTableViewCell.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var listingData: ListingData? {
        didSet {
            displayData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        displayData()
    }
    
    func displayData() {
        name.text = listingData?.title
        releaseDate.text = listingData?.releaseDate
        detail.text = listingData?.overview
        movieImage.setImage(imageURL: listingData?.posterPath)
    }
}

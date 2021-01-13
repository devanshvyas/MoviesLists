//
//  ImagesCell.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

class ImagesCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    var details: Details? {
        didSet {
            display()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        display()
    }

    func display() {
        coverImage.setImage(imageURL: details?.backdropPath)
        posterImage.setImage(imageURL: details?.posterPath)
        title.text = details?.title
        overview.text = details?.tagline
    }

}

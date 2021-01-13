//
//  DetailsCell.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var titleText: String? {
        didSet {
            title.text = titleText
        }
    }
    
    var detailText: String? {
        didSet {
            detail.text = detailText
        }
    }
}

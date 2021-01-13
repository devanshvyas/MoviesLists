//
//  UIImageView.swift
//
//  Created by Devansh Vyas on 31/12/20.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(imageURL: String?, placeholderImage: UIImage? =  nil, showPlaceHolder: Bool = true, isPosterImage: Bool = true) {
        let preUrl = isPosterImage ? ApiServices.shared.posterUrl : ApiServices.shared.coverUrl
        if let imageString = imageURL, let url = URL(string: preUrl + imageString) {
            image = nil
            var kingFisher = self.kf
            kingFisher.indicatorType = .activity
            let activity = kingFisher.indicator?.view as? UIActivityIndicatorView
            activity?.style = UIActivityIndicatorView.Style.medium
            
            kingFisher.setImage(
                with: url,
                placeholder: placeholderImage,
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage], completionHandler:  { result in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    })
        } else {
            if showPlaceHolder {
                self.image = placeholderImage
            }
        }
    }
}

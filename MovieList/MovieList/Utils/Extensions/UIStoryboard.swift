//
//  UIStoryboard.swift
//  MovieList
//
//  Created by Devansh Vyas on 13/01/21.
//

import UIKit

extension UIStoryboard {
    func instantiate<T: UIViewController>() -> T {
        if #available(iOS 13.0, *) {
            guard let viewController = self.instantiateViewController(identifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }

            return viewController
        } else {
            guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }

            return viewController
        }
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

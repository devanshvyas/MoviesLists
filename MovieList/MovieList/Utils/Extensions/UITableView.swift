//
//  UITableView.swift
//  TaskDemo
//
//  Created by Devansh Vyas on 31/12/20.
//

import UIKit

extension UITableView {
    /// Register Cell
    func registerCell(id: String) {
        let cellNib = UINib(nibName: id, bundle: nil)
        register(cellNib, forCellReuseIdentifier: id)
    }

    func reloadDataAtIndex(index: Int) {
        self.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }

    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }

    func dequeue<T: UITableViewCell>(_ obj: T.Type, for indexPath: IndexPath) -> T {
        guard
            let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                           for: indexPath) as? T
            else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }

    func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        )
    }
}

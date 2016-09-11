//
//  Selectable.swift
//  TableViewKit
//
//  Created by Alfredo Delli Bovi on 29/08/16.
//  Copyright © 2016 odigeo. All rights reserved.
//

import Foundation

public protocol Selectable: Item {
    var onSelection: (Selectable) -> () { get set }

    func select(inManager manager: TableViewManager, animated: Bool, scrollPosition: UITableViewScrollPosition)
    func deselect(inManager manager: TableViewManager, animated: Bool)
}

extension Selectable {

    public func select(inManager manager: TableViewManager, animated: Bool, scrollPosition: UITableViewScrollPosition = .none) {

        manager.tableView.selectRow(at: indexPath(inManager: manager), animated: animated, scrollPosition: scrollPosition)
        manager.tableView(manager.tableView, didSelectRowAt: indexPath(inManager: manager)!)
    }

    public func deselect(inManager manager: TableViewManager, animated: Bool) {
        guard let indexPath = indexPath(inManager: manager) else { return }
        
        manager.tableView.deselectRow(at: indexPath, animated: animated)
    }

}

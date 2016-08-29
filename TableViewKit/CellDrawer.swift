//
//  TableViewDrawerCell.swift
//  TableViewKit
//
//  Created by Nelson Dominguez Leon on 29/06/16.
//  Copyright © 2016 ODIGEO. All rights reserved.
//

import Foundation
import UIKit

public protocol CellDrawer {
    
    static var cellType: CellType { get }
    static func cell(inManager manager: TableViewManager, withItem item: ItemProtocol, forIndexPath: NSIndexPath) -> BaseCell
    static func draw(cell cell: BaseCell, withItem item: Any)
    
}

public extension CellDrawer {
    static func cell(inManager manager: TableViewManager, withItem item: ItemProtocol, forIndexPath indexPath: NSIndexPath) -> BaseCell {
        let cell = manager.tableView.dequeueReusableCellWithIdentifier(self.cellType.reusableIdentifier, forIndexPath: indexPath) as! BaseCell
        cell.tableViewManager = manager
        cell.item = item
        return cell
    }
}
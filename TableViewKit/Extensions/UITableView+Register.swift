//
//  UITableView+Register.swift
//  Pods
//
//  Created by Alfredo Delli Bovi on 28/08/16.
//
//

import UIKit

public extension UITableView {
    public func register(type type: CellType, bundle: NSBundle? = nil) {
        switch type {
        case .Class(let cellClass):
            registerClass(cellClass, forCellReuseIdentifier: type.reusableIdentifier)
        case .Nib(let nib, _):
            registerNib(nib, forCellReuseIdentifier: type.reusableIdentifier)
        }
    }

    public func register(type type: HeaderFooterType, bundle: NSBundle? = nil) {
        switch type {
        case .Class(let cellClass):
            registerClass(cellClass, forHeaderFooterViewReuseIdentifier: type.reusableIdentifier)
        case .Nib(let nib, _):
            registerNib(nib, forHeaderFooterViewReuseIdentifier: type.reusableIdentifier)
        }
    }
    
    func moveRows(at indexPaths: [NSIndexPath], to newIndexPaths: [NSIndexPath]) {
        for (index, _) in indexPaths.enumerate() {
            moveRowAtIndexPath(indexPaths[index], toIndexPath: newIndexPaths[index])
        }
    }

}
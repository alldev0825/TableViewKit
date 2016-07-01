//
//  ODGTableViewItem.swift
//  TableViewKit
//
//  Created by Nelson Dominguez Leon on 07/06/16.
//  Copyright © 2016 ODIGEO. All rights reserved.
//

import Foundation
import UIKit

public protocol ODGTableViewItemProtocol: class {
    
    /// Section
    weak var section: ODGTableViewSectionProtocol! { get set }
    
    /// Drawer used to draw cell. Strategy pattern
    var drawer: ODGTableViewDrawerCellProtocol { get set }
    
    /// Cell data
    var image: UIImage? { get set }
    var title: String? { get set }
    var subtitle: String? { get set }
    
    var cellStyle: UITableViewCellStyle { get set }
    var accessoryType: UITableViewCellAccessoryType { get set }
    var accessoryView: UIView? { get set }
    var cellHeight: Float { get set }
    var indexPath: NSIndexPath? { get set }
    
    var selectionHandler: ((ODGTableViewItemProtocol) -> ())? { get set }
    var name: String? { get set }
    var validators: [ODGValidator] { get set }
    
    func errors() -> [NSError]
    
    func selectRowAnimated(animated: Bool)
    func selectRowAnimated(animated: Bool, scrollPosition: UITableViewScrollPosition)
    func deselectRowAnimated(animated: Bool)
    func reloadRowWithAnimation(animation: UITableViewRowAnimation)
    func deleteRowWithAnimation(animation: UITableViewRowAnimation)
}

func ==(lhs: ODGTableViewItemProtocol, rhs: ODGTableViewItemProtocol) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}

func !=(lhs: ODGTableViewItemProtocol, rhs: ODGTableViewItemProtocol) -> Bool {
    return ObjectIdentifier(lhs) != ObjectIdentifier(rhs)
}

public class ODGTableViewItem: ODGTableViewItemProtocol {
    
    public weak var section: ODGTableViewSectionProtocol!
    
    public var drawer: ODGTableViewDrawerCellProtocol
    
    // MARK: Cell values
    
    public var image: UIImage?
    public var title: String?
    public var subtitle: String?
    
    // MARK: Cell style
    
    public var cellStyle: UITableViewCellStyle
    public var accessoryType: UITableViewCellAccessoryType
    public var accessoryView: UIView?
    public var cellHeight: Float
    public var indexPath: NSIndexPath?
    
    // MARK: Handlers
    
    public var selectionHandler: ((ODGTableViewItemProtocol) -> ())?
    
    // MARK: Error validations
    
    /// Name of item, used in validation system to generate the error
    public var name: String?
    
    /// Array of validators. See ODGPresenceValidator, ODGEmailValidator
    /// Note: You can create your custom validator, implementing ODGValidator protocol
    public var validators: [ODGValidator] = []
    
    /**
     Add a validator
    */
    public func add(validator validator:ODGValidator) {
        validators.append(validator)
    }
    
    /**
     Rewrite this function and call to Validation system
     Example: ODGValidation.validate(objectToValidate, name: self.name, validators: self.validators)
     
     - returns: Array of errors
     */
    public func errors() -> [NSError] {
        return []
    }
    
    // MARK: Manipulating table view row
    
    public func selectRowAnimated(animated: Bool) {
        
        selectRowAnimated(animated, scrollPosition: .None)
    }
    
    public func selectRowAnimated(animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        section.tableViewManager.tableView.selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    public func deselectRowAnimated(animated: Bool) {
        
        if let itemIndexPath = indexPath {
            section.tableViewManager.tableView.deselectRowAtIndexPath(itemIndexPath, animated: animated)
        }
    }
    
    public func reloadRowWithAnimation(animation: UITableViewRowAnimation) {
        
        if let itemIndexPath = indexPath {
            section.tableViewManager.tableView.reloadRowsAtIndexPaths([itemIndexPath], withRowAnimation: animation)
        }
    }
    
    public func deleteRowWithAnimation(animation: UITableViewRowAnimation) {
        
        if let itemIndexPath = indexPath {
            section.tableViewManager.tableView.deleteRowsAtIndexPaths([itemIndexPath], withRowAnimation: animation)
        }
    }
    
    // MARK: Constructor
    
    public init() {
        
        drawer = ODGTableViewDrawerCell()
        
        cellStyle = .Default
        accessoryType = .None
        cellHeight = 44.0
    }
    
    public convenience init(title: String, subtitle: String?) {
        
        self.init()
        self.title = title
        self.subtitle = subtitle
    }
}

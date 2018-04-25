//
//  UITableView+ViewAnimator.swift
//  Shopper
//
//  Created by John Forde on 24/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

public extension UITableView {

	/// Gets the currently visibleCells of a section.
	///
	/// - Parameter section: The section to filter the cells.
	/// - Returns: Array of visible UITableViewCell in the argument section.
	func visibleCells(in section: Int) -> [UITableViewCell] {
		return visibleCells.filter { indexPath(for: $0)?.section == section }
	}
}

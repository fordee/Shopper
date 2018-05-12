//
//  DeepDiff.swift
//  Shopper
//
//  Created by John Forde on 9/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

/// Perform diff between old and new collections
///
/// - Parameters:
///   - old: Old collection
///   - new: New collection
/// - Returns: A set of changes
public func diff<T: Hashable>(
	old: Array<T>,
	new: Array<T>,
	algorithm: DiffAware = WagnerFischer()) -> [Change<T>] {

	if let changes = algorithm.preprocess(old: old, new: new) {
		return changes
	}

	return algorithm.diff(old: old, new: new)
}

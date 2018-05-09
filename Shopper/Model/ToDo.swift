//
//  ToDo.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

// This is the bare Photo model.
struct ToDo: Equatable { // Equatable is free with Swift 4.1!
	var category = ""
	var description = ""
	var done = ""
	var shoppingCategory = ""
	var isDone: Bool {
		return done == "true"
	}

	mutating func toggleDone() {
		if isDone {
			done = "false"
		} else {
			done = "true"
		}
	}
}

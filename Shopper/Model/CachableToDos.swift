//
//  CachableToDos.swift
//  Shopper
//
//  Created by John Forde on 25/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Foundation

struct CachableToDos: Cachable, Codable {
	let todos: [ToDo]

	var fileName: String {
		return "todos"
	}

	init(todos: [ToDo]) {
		self.todos = todos
	}
}


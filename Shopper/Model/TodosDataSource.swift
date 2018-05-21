//
//  TodosDataSource.swift
//  Shopper
//
//  Created by John Forde on 22/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Foundation

public class ToDosDataSource {

	static var todos: [ToDo] = []

	@objc	static func refresh() {
		ToDo.fetchToDos().then { fetchedToDos in
			self.todos = fetchedToDos.filter { toDo in
				return toDo.category == "Shopping"
			}
			}.onError { e in
				print(e)
			}.finally {
				self.todos.sort() { lhs, rhs in // Complex sorting logic
					if (lhs.done != rhs.done) {
						if lhs.done == "false" {
							return true
						} else {
							return false
						}
					}
					if lhs.shoppingCategory > rhs.shoppingCategory {
						return true
					}
					return false
				}
				NotificationCenter.default.post(name: .refreshTodos, object: nil)
		}
	}
}

extension Notification.Name {
	static let refreshTodos = Notification.Name("refreshToDos")
}

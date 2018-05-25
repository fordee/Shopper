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
	static let cacher: Cacher = Cacher(destination: .temporary)

	@objc	static func refresh() {
		// First make a network request for todos
		ToDo.fetchToDos().then { fetchedToDos in
			self.todos = fetchedToDos.filter { toDo in
				return toDo.category == "Shopping"
			}

			}.onError { e in
				print(e)
			}.finally {
				self.todos.sort { lhs, rhs in // Complex sorting logic
					if lhs.done != rhs.done {
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
				// Now cache the todos
				let cachableTodos = CachableToDos(todos: self.todos)
				cacher.persist(item: cachableTodos) { url, error in
					if let error = error {
						print("ToDos failed to persist: \(error)")
					} else {
						print("ToDos persisted in \(String(describing: url))")
					}
				}
				NotificationCenter.default.post(name: .refreshTodos, object: nil, userInfo: ["animated": false])
		}
		// In the meantime, load our cached source
		if let cachedTodos: CachableToDos = cacher.load(fileName: "todos") {
			todos = cachedTodos.todos
			NotificationCenter.default.post(name: .refreshTodos, object: nil, userInfo: ["animated": true])
		}
	}
}

extension Notification.Name {
	static let refreshTodos = Notification.Name("refreshToDos")
}

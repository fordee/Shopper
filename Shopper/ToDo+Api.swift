//
//  ToDo+Api.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import then

// This is not absolutely needed but it's nice to handle data through
// the models.

extension ToDo {
	static func fetchToDos() -> Promise<[ToDo]> {
		return api.fetchToDos()
	}

	func save() -> Promise<ToDo> {
		return api.save(path: "/items", params: ["category": category, "description": description, "done": done])
	}
}

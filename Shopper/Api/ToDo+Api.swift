//
//  ToDo+Api.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import then

extension ToDo {
	static func fetchToDos() -> Promise<[ToDo]> {
		return api.fetchToDos()
	}

	func save() -> Promise<ToDo> {
		return api.save(path: "/items", params: ["category": category, "description": description, "done": done])
	}

	func update() -> Promise<ToDo> {
		return api.update(path: "/items", params: ["category": category, "description": description, "done": done])
	}

	func delete() -> Promise<Void> {
		let deleteString = "/items/\(description)/Shopping".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
		print("Delete String: \(deleteString)")
		return api.delete(path: deleteString)
	}
}

//
//  WSApi.swift
//  StarterProject
//
//  Created by Sacha Durand Saint Omer on 30/01/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import ws
import Alamofire
import then

// This is our JSON Api Code
// Yes! This is all that's needed to get nice Swift models from a JSON api!!!!
// Thanks to the power of generics, ws will return what you want! (Void, JSON, Model, [Model] etc)

// Get the full documentation at https://github.com/freshOS/ws

class WSApi: ApiInterface {

	let ws = WS("https://shoppy.4Dware.net") // Set the Webservice base URL

	init() {
		// This will print network requests & responses to the console.
		ws.logLevels = .debug
	}

	// Set the type you want back and call the endpoint you need.
	func fetchToDos() -> Promise<[ToDo]> {
		print("Fetching To Do's...")
		return ws.get("/items")
	}

	func save(path: String, params: Params) -> Promise<ToDo> {
		print("Adding \(params)...")
		ws.postParameterEncoding = JSONEncoding.default
		return ws.post(path, params: params)
	}
}

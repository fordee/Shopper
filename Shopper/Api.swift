//
//  Api.swift
//  StarterProject
//
//  Created by Sacha Durand Saint Omer on 30/01/2017.
//  Copyright © 2017 4DWare. All rights reserved.
//

import then
import ws

// This is our Api interface.
// In theory we could use ws directly in controllers but this wouldn't be very clean.
// Here we invert the depedency by puting an <ApiInterface> interface between view Controllers
// and Networking code.
// Thanks to this layer of abstraction, we could even swap api implementation at runtime if we'd like to !
// See "Dependency inversion principle" for more details.

protocol ApiInterface {
	func fetchToDos() -> Promise<[ToDo]>
	func save(path: String, params: Params) -> Promise<ToDo>
}

var api: ApiInterface!

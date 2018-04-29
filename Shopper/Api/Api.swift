//
//  Api.swift
//  Shopper
//

import then
import ws

protocol ApiInterface {
	func fetchToDos() -> Promise<[ToDo]>
	func save(path: String, params: Params) -> Promise<ToDo>
	func update(path: String, params: Params) -> Promise<ToDo>
	func delete(path: String) -> Promise<Void>
	
	func fetchFrequentItems() -> Promise<[FrequentItem]>
	func saveFrequentItem(path: String, params: Params) -> Promise<FrequentItem>
}

var api: ApiInterface!

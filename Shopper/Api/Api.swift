//
//  Api.swift
//  Shopper
//

import then
import ws

protocol ApiInterface {
	// ToDos
	func fetchToDos() -> Promise<[ToDo]>
	func save(path: String, params: Params) -> Promise<ToDo>
	func update(path: String, params: Params) -> Promise<ToDo>
	func delete(path: String) -> Promise<Void>

	// Frequent Items
	func fetchFrequentItems() -> Promise<[FrequentItem]>
	func saveFrequentItem(path: String, params: Params) -> Promise<FrequentItem>

	// Shops
	func fetchShops() -> Promise<[Shop]>

	// Aisles
	func deleteAisle(path: String) -> Promise<Void>
	func addAisle(path: String, params: Params) -> Promise<Aisle>
}

var api: ApiInterface!

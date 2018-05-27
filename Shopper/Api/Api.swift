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
	func deleteFrequentItem(path: String) -> Promise<Void>

	// Shops
	func fetchShops() -> Promise<[Shop]>
	func addShop(path: String, params: Params) -> Promise<Shop>

	// Aisles
	func deleteAisle(path: String) -> Promise<Void>
	func addAisle(path: String, params: Params) -> Promise<Aisle>
	func updateAisle(path: String, params: Params) -> Promise<Aisle>

	// Categories
	func addCategory(path: String, params: Params) -> Promise<String>
	func deleteCategory(path: String) -> Promise<Void>
}

var api: ApiInterface!

//
//  WSApi.swift



import ws
import Alamofire
import then

// Get the full documentation at https://github.com/freshOS/ws

class WSApi: ApiInterface {

	private var baseURL: URL? = URL(string: "api.example.com")
	let ws: WS

	init() {
		// This will print network requests & responses to the console.
		guard
			let path = Bundle.main.path(forResource: "Api", ofType: "plist"),
			let values = NSDictionary(contentsOfFile: path) as? [String: Any],
			let apiEndpoint = values["API Endpoint"] as? String
			else {
				fatalError("Api.plist file is missing 'API Endpoint' entry!")
		}
		ws = WS(apiEndpoint) // Set the Webservice base URL
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

	func update(path: String, params: Params) -> Promise<ToDo> {
		print("Updating \(params)...")
		ws.postParameterEncoding = JSONEncoding.default
		return ws.put(path, params: params)
	}

	func delete(path: String) -> Promise<Void> {
		print("Deleting \(path)...")
		return ws.delete(path)
	}

	func fetchFrequentItems() -> Promise<[FrequentItem]> {
		print("Fetching To Do's...")
		return ws.get("/common-items")
	}
}

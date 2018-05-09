
import Arrow

extension ToDo : ArrowParsable {
	public mutating func deserialize(_ json: JSON) {
		category  <-- json["category"]
		description <-- json["description"]
		shoppingCategory <-- json["shoppingCategory"]
		done <-- json["done"]
	}

}

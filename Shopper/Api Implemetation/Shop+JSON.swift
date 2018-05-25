//
//  Shop+JSON.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//
import Arrow

extension Shop: ArrowParsable {

	public func deserialize(_ json: JSON) {
		name  <-- json["name"]
		aisles <-- json["aisles"]
	}

}

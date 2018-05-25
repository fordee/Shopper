//
//  Aisle+JSON.swift
//  Shopper
//
//  Created by John Forde on 14/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Arrow

extension Aisle: ArrowParsable {

	public func deserialize(_ json: JSON) {
		title <-- json["title"]
		aisleNumber <-- json["aisleNumber"]
		categories <-- json["categories"]
	}
}

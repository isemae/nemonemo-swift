//
//  Model.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/5/24.
//

import UIKit
import Foundation

struct ColorData {
	var id: UUID
	var color: UIColor
	
	
}


extension ColorData: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(color)
	}
	
	static func ==(lhs: ColorData, rhs: ColorData) -> Bool {
		return lhs.id == rhs.id && lhs.color == rhs.color
	}
}

//
//  Model.swift
//  nemonemo
//
//  Created by Jiwoon Lee on 2/5/24.
//

import Foundation
import UIKit

struct Gato {
	var name: String
	var desc: String
	var symbol: String
}

enum Gatos: CaseIterable{
	case bongoCat
	case punchCat
	case bendCat
	var gato: Gato {
		switch self {
		case .bongoCat:
			return Gato(name: "bongoCat", desc: "Bonk", symbol: "hand.raised.circle")
		case .punchCat:
			return Gato(name: "punchCat", desc: "NN Punch", symbol: "pawprint.circle")
		case .bendCat:
			return Gato(name: "bendCat", desc: "Do Not Bend", symbol: "doc.circle" )
		}
	}
}
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

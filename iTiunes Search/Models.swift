//
//  Models.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
	struct Result: Codable {
		let artistName: String
		let collectionName: String
		let artworkUrl60: URL?
		let artworkUrl100: URL?
	}

	let resultCount: Int
	let results: [Result]
}

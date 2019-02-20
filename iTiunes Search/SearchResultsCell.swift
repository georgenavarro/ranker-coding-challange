//
//  SearchResultsCell.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import UIKit

class SearchResultsCell: UITableViewCell {
	@IBOutlet weak var artworkImageView: UIImageView?
	@IBOutlet weak var artistNameLabel: UILabel?
	@IBOutlet weak var collectionNameLabel: UILabel?

	private var dataTask: URLSessionDataTask?
}

extension SearchResultsCell {
	override func prepareForReuse() {
		super.prepareForReuse()
		self.dataTask?.cancel()
		self.dataTask = nil
	}
}

extension SearchResultsCell {
	func displayImage(at url: URL?) {
		self.dataTask?.cancel()
		self.dataTask = self.artworkImageView?.displayImage(at: url)
	}
}

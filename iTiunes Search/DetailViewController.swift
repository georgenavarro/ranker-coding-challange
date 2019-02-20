//
//  DetailViewController.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet private weak var artworkImageView: UIImageView?
	@IBOutlet private weak var artistNameLabel: UILabel?
	@IBOutlet private weak var collectionNameLabel: UILabel?

	var result: SearchResults.Result? {
		didSet {
			self.updateContent()
		}
	}
}

extension DetailViewController {
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.updateContent()
	}
}

extension DetailViewController {
	private func updateContent() {
		self.title = result?.collectionName
		self.artworkImageView?.displayImage(at: self.result?.artworkUrl100 ?? self.result?.artworkUrl60)
		self.artistNameLabel?.text = result?.artistName
		self.collectionNameLabel?.text = result?.collectionName
	}
}

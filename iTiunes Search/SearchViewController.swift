//
//  SearchViewController.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
	@IBOutlet private weak var searchBar: UISearchBar?
}

extension SearchViewController {
	private static let cellReuseIdentifire = "ResultCell"

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCell(
			withIdentifier: SearchViewController.cellReuseIdentifire,
			for: indexPath
		)

		return cell
	}
}

extension SearchViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.fetchResults()
	}
}

extension SearchViewController {
	@objc private func fetchResults() {
		guard let searchTerm: String = self.searchBar?.text else {
			return
		}

		let endpoint: Endpoint = Endpoint.search(
			term: searchTerm,
			media: .music,
			entity: .album
		)

		guard let url: URL = endpoint.url else {
			return
		}


		let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
			// TODO: parse data
		}

		dataTask.resume()
	}
}

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

	private var results: [SearchResults.Result] = []
}

extension SearchViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if
			let cell: UITableViewCell = sender as? UITableViewCell,
			let indexPath: IndexPath = self.tableView.indexPath(for: cell),
			self.results.indices.contains(indexPath.row)
		{
			let detailViewController: DetailViewController? = segue.destination as? DetailViewController
			detailViewController?.result = self.results[indexPath.row]
		}
	}
}

extension SearchViewController {
	private static let cellReuseIdentifire = "ResultCell"

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.results.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = tableView.dequeueReusableCell(
			withIdentifier: SearchViewController.cellReuseIdentifire,
			for: indexPath
		)

		guard let searchResultCell: SearchResultsCell = cell as? SearchResultsCell else {
			return cell
		}

		var result: SearchResults.Result?

		if self.results.indices.contains(indexPath.row) {
			result = self.results[indexPath.row]
		}

		searchResultCell.artistNameLabel?.text = result?.artistName
		searchResultCell.collectionNameLabel?.text = result?.collectionName
		searchResultCell.displayImage(at: result?.artworkUrl60)

		return searchResultCell
	}
}

extension SearchViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(
			at: indexPath,
			animated: true
		)
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

		endpoint.fetch { [weak self] (searchResults: SearchResults?, response: URLResponse?, error: Error?) -> Void in
			DispatchQueue.main.async {
				self?.results = searchResults?.results ?? []
				self?.tableView.reloadData()
			}
		}
	}
}

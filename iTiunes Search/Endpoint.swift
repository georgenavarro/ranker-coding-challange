//
//  Endpoint.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import Foundation

enum MediaType: String {
	case movie
	case podcast
	case music
	case musicVideo
	case audiobook
	case shortFilm
	case tvShow
	case software
	case ebook
	case all
}

enum EntityType: String {
	// Movie Entity Types
	case movieArtist
	case movie

	// Pocase Entity Types
	case podcastAuthor
	case podcast

	// Music Entity Types
	case musicTrack
	case album
	case mix
	case song

	// Music and Music Video Entity Types
	case musicArtist
	case musicVideo

	// Audioboon Entity Types
	case audiobookAuthor
	case audiobook

	// Shortfilm Entity Types
	case shortFilmArtist
	case shortFilm

	// Tvshow Entity Types
	case tvEpisode
	case tvSeason

	// Software Entity Types
	case software
	case iPadSoftware
	case macSoftware

	// Ebook Entity Tyoes
	case ebook

	// All Entity Types
	case allTrack
}

enum Endpoint {
	case search(term: String, media: MediaType, entity: EntityType?)
}

extension Endpoint {
	var path: String {
		switch self {
		case .search:
			return "/search"
		}
	}

	var queryItems: [URLQueryItem] {
		switch self {
		case let .search(term, media, entity):
			var queryItems: [URLQueryItem] = [
				URLQueryItem(name: "term", value: term),
				URLQueryItem(name: "media", value: media.rawValue)
			]

			if let entity: EntityType = entity {
				let entityQueryItem: URLQueryItem = URLQueryItem(name: "entity", value: entity.rawValue)
				queryItems.append(entityQueryItem)
			}

			return queryItems
		}
	}
}

extension Endpoint {
	func fetch<Type: Codable>(completionHandler: @escaping (Type?, URLResponse?, Error?) -> Void) {
		var urlComponents: URLComponents? = URLComponents(string: "https://itunes.apple.com")
		urlComponents?.path = self.path
		urlComponents?.queryItems = self.queryItems

		guard let url: URL = urlComponents?.url else {
			completionHandler(
				nil,
				nil,
				nil
			)

			return
		}

		let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
			var result: Type?
			var finalError: Error? = error
			let decoder: JSONDecoder = JSONDecoder()

			if let data: Data = data {
				do {
					result = try decoder.decode(
						Type.self,
						from: data
					)
				} catch {
					finalError = error
				}
			}

			completionHandler(
				result,
				response,
				finalError
			)
		}

		dataTask.resume()
	}
}

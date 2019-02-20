//
//  UIImage+Utilities.swift
//  iTiunes Search
//
//  Created by George Navarro on 2/19/19.
//  Copyright © 2019 Seventh Bit Studios. All rights reserved.
//

import UIKit

extension UIImageView {
	@discardableResult func displayImage(at url: URL?) -> URLSessionDataTask? {
		self.image = nil

		guard let url: URL = url else {
			return nil
		}

		let request: URLRequest = URLRequest(url: url)
		var dataTask: URLSessionDataTask?

		if let cachedResponse: CachedURLResponse = URLCache.shared.cachedResponse(for: request) {
			self.image = UIImage(data: cachedResponse.data)
		} else {
			dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
				guard
					let data: Data = data,
					let image: UIImage = UIImage(data: data),
					let imageView: UIImageView = self
				else {
					return
				}

				DispatchQueue.main.async {
					UIView.transition(
						with: imageView,
						duration: 0.3,
						options: .transitionCrossDissolve,
						animations: {
							imageView.image = image
						},
						completion: nil
					)
				}
			}

			dataTask?.resume()
		}

		return dataTask
	}
}

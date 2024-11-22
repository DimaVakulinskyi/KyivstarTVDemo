//
//  UIImageView+Extensions.swift
//  DemoApp
//
//  Created by Dmytro Vakulinskyi on 19.11.2024.
//

import UIKit

extension UIImageView {
    private static var tasks: [UIImageView: URLSessionDataTask] = [:]

    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder

        if let cachedImage = ImageCache.shared.image(for: url) {
            self.image = cachedImage
            return
        }

        UIImageView.tasks[self]?.cancel()
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                ImageCache.shared.setImage(image, for: url)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }

        UIImageView.tasks[self] = task
        task.resume()
    }

    func cancelImageLoad() {
        UIImageView.tasks[self]?.cancel()
        UIImageView.tasks[self] = nil
    }
}

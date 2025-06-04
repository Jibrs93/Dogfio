//
//  UIImage+App.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import UIKit

extension UIImageView {
    
    func loadImage(from urlString: String?, placeholder: UIImage? = nil) {
        self.image = placeholder

        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}

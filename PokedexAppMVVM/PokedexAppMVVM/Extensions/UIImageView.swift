//
//  UIImageView.swift
//  PokedexAppMVVM
//
//  Created by Salva Moreno on 8/10/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(for url: URL) {
        downloadImage(url: url) { [weak self] result in
            guard case let .success(image) = result else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    private func downloadImage(
        url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, _ in
            let result: Result<UIImage, Error>
            
            defer {
                completion(result)
            }
            
            guard let data, let image = UIImage(data: data) else {
                result = .failure(NSError(domain: "No image", code: -1))
                return
            }
            
            result = .success(image)
        }
        
        task.resume()
    }
}

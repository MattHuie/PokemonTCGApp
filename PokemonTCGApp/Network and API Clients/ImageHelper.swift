//
//  ImageHelper.swift
//  PokemonTCGApp
//
//  Created by Matthew Huie on 12/19/18.
//  Copyright © 2018 Matthew Huie. All rights reserved.
//

import UIKit

final class ImageHelper {
    static func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completionHandler(nil, image)
                }
            }
        }
    }
}

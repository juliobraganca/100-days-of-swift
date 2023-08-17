//
//  Image.swift
//  app-from-scratch-04
//
//  Created by Júlio Bragança on 06/05/23.
//

import Foundation

struct Image: Codable {
    var imageName: String
    var image: String

    var imagePath: String {
        return Bundle.main.documentsDirectory.appendingPathExtension(image).path()
    }
}

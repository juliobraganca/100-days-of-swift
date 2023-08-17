//
//  File.swift
//  app-from-scratch-04
//
//  Created by Júlio Bragança on 08/05/23.
//

import Foundation

extension Bundle {
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}

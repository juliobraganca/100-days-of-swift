//
//  Detail.swift
//  28-Milestone-Projects19-21
//
//  Created by Julio Braganca on 17/08/23.
//

import Foundation

class Detail: Codable {
    var text: String
    var modificationDate: Date
    
    init(text: String, modificationDate: Date) {
        self.text = text
        self.modificationDate = modificationDate
    }
}

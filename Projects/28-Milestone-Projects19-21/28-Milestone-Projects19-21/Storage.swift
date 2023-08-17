//
//  Storage.swift
//  28-Milestone-Projects19-21
//
//  Created by Julio Braganca on 17/08/23.
//

import Foundation

class Storage {
    static let notesKey = "notes"
    
    // run on background thread
    static func load() -> [Detail] {
        let defaults = UserDefaults.standard
        var notes = [Detail]()
        
        if let savedData = defaults.object(forKey: notesKey) as? Data {
            let jsonDecoder = JSONDecoder()
            notes = (try? jsonDecoder.decode([Detail].self, from: savedData)) ?? notes
        }
        
        return notes
    }
    
    // run on background thread
    static func save(notes: [Detail]) {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: notesKey)
        }
    }
}

//
//  Capital.swift
//  Project 16
//
//  Created by Julio Braganca on 18/05/23.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var wikipedia: String
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, wikipedia: String, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.wikipedia = wikipedia
        self.info = info
    }
}

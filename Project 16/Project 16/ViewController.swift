//
//  ViewController.swift
//  Project 16
//
//  Created by Julio Braganca on 18/05/23.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(mapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), wikipedia: "https://en.wikipedia.org/wiki/London", info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),wikipedia: "https://en.wikipedia.org/wiki/Oslo", info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),wikipedia: "https://en.wikipedia.org/wiki/Paris", info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),wikipedia: "https://en.wikipedia.org/wiki/Rome", info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667),wikipedia: "https://en.wikipedia.org/wiki/Washington,_D.C.", info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }

        let identifier = "Capital"

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = .blue
            annotationView?.canShowCallout = true

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        let placeWiki = capital.wikipedia
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        
        let wiki = UIAlertAction(title: "Wikipedia", style: .default) { action in
            if let url = URL(string: capital.wikipedia) {
                UIApplication.shared.open(url)
            }
        }
        
        let ok = UIAlertAction(title: "Ok", style: .default)
        
        ac.addAction(wiki)
        ac.addAction(ok)
        present(ac, animated: true)
    }
    
    @objc func mapType() {
        let ac = UIAlertController(title: "Choose Map Type", message: nil, preferredStyle: .actionSheet)
        
        let standard = UIAlertAction(title: "Standard", style: .default) { action in
            self.mapView.mapType = .standard
        }
        
        let satellite = UIAlertAction(title: "Satellite", style: .default) { action in
            self.mapView.mapType = .satellite
        }
        
        let hybrid = UIAlertAction(title: "Hybrid", style: .default) { action in
            self.mapView.mapType = .hybrid
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(standard)
        ac.addAction(satellite)
        ac.addAction(hybrid)
        ac.addAction(cancel)
        present(ac, animated: true)
    }

}


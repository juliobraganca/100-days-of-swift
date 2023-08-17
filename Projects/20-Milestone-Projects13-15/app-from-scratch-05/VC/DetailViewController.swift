//
//  DetailViewController.swift
//  app-from-scratch-05
//
//  Created by Julio Braganca on 25/05/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subRegionLabel: UILabel!
    
    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = country.name.common
        navigationItem.largeTitleDisplayMode = .never
        
        setDetailsForCountry()
    }
    
    func setDetailsForCountry() {
        flagImageView.image = UIImage(named: country.flagImageName)
        flagImageView.layer.borderColor = UIColor.lightGray.cgColor
        flagImageView.layer.borderWidth = 1
        capitalLabel.text = "Capital: \(country.capital.joined(separator: ","))"
        countryCodeLabel.text = "Country code: \(country.code)"
        populationLabel.text = "Population: \(country.population.formatted(.number))"
        regionLabel.text = "Region: \(country.region)"
        subRegionLabel.text = "Subregion: \(country.subregion)"
    }
}

//
//  ViewController.swift
//  app-from-scratch-05
//
//  Created by Julio Braganca on 25/05/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Country Information"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadCountries), with: nil)
    }
    
    @objc func loadCountries(){
        let codes = Country.countryCodes.joined(separator: ",")
        
        guard let url = URL(string: "https://restcountries.com/v3.1/alpha?codes=\(codes)") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let jsonCountries = try JSONDecoder().decode([Country].self, from: data)
            countries = jsonCountries
            print(jsonCountries)
        } catch {
            print("Countries Information not loaded")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        
        if let cell = cell as? CountryCell {
            cell.cellFlagImageView.image = UIImage(named: country.flagImageName)
            cell.cellFlagImageView.layer.borderColor = UIColor.lightGray.cgColor
            cell.cellFlagImageView.layer.borderWidth = 1
            cell.cellFlagImageView.layer.cornerRadius = 8
            
            cell.cellCountryNameLabel.text = country.name.common
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.country = country
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


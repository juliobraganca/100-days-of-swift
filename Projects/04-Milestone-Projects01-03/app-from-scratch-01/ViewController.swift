//
//  ViewController.swift
//  app-from-scratch-01
//
//  Created by Júlio Bragança on 10/04/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var countryRow: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Country Flags!"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        pictures += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  // how many rows should appear
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch pictures[indexPath.row]{
            case "us":
                countryRow = pictures[indexPath.row].uppercased()
            case "uk":
                countryRow = pictures[indexPath.row].uppercased()
            default:
                countryRow = pictures[indexPath.row].capitalized
            }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = countryRow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


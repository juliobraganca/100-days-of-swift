//
//  ViewController.swift
//  Project 01
//
//  Created by Júlio Bragança on 08/04/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var viewCount: [String: Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //        let fm = FileManager.default
        //        let path = Bundle.main.resourcePath!
        //        let items = try! fm.contentsOfDirectory(atPath: path)
        
        performSelector(inBackground: #selector(loadingNSSL), with: nil)
        loadUserDefaults()
        
        print(pictures)
    }
    
    @objc func loadingNSSL() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                pictures.append(item)
                pictures.sort()
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func loadUserDefaults() {
        if let viewCount = UserDefaults.standard.object(forKey: "viewCount") as? [String: Int] {
            self.viewCount = viewCount
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let picture = pictures[indexPath.row]
        cell.textLabel?.text = picture
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20) // Challenge 1
        // cell.textLabel?.adjustsFontSizeToFitWidth = true // to adjust to fit Width
        
        if let count = viewCount[picture] {
            cell.detailTextLabel?.text = "Views: \(count)"
        } else {
            cell.detailTextLabel?.text = "Views: None"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            fatalError("Unable to instantiate DetailViewController")
        }
        let selectedPicture = pictures[indexPath.row]
        
        if viewCount[selectedPicture] != nil {
            // key exists
            viewCount[selectedPicture]? += 1
        } else {
            viewCount[selectedPicture] = 1
        }
        
        UserDefaults.standard.set(viewCount, forKey: "viewCount")
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        // 2: success! Set its selectedImage property
        vc.selectedImagePosition = indexPath.row + 1  // challenge 3: Set values to selectedImagePosition & totalNumberOfImages. // "+1" to show human-readable index number instead of Swift index number approach
        vc.totalPictures = pictures.count // challenge 3: total count of pictures array
        
        // 3: now push it onto the navigation controller
        vc.selectedImage = selectedPicture
        navigationController?.pushViewController(vc, animated: true)
    }
}


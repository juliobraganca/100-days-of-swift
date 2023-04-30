//
//  ViewController.swift
//  Project 01
//
//  Created by Júlio Bragança on 08/04/23.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath!
//        let items = try! fm.contentsOfDirectory(atPath: path)
        
        performSelector(inBackground: #selector(loadingNSSL), with: nil)
        
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
            self?.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue Picture Cell.")
        }
        cell.nameLabel.text = pictures[indexPath.item]
        cell.nameLabel.font = UIFont.systemFont(ofSize: 20) // Challenge 1
        cell.imageView.image = UIImage(named: pictures[indexPath.item])
        cell.imageView.contentMode = .scaleAspectFit
        // cell.textLabel?.adjustsFontSizeToFitWidth = true // to adjust to fit Width
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImagePosition = indexPath.row + 1  // challenge 3: Set values to selectedImagePosition & totalNumberOfImages. // "+1" to show human-readable index number instead of Swift index number approach
            vc.totalPictures = pictures.count // challenge 3: total count of pictures array

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//
//  DetailViewController.swift
//  app-from-scratch-04
//
//  Created by Júlio Bragança on 06/05/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: Image?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedImage = selectedImage {
            print("Attempting to load detail image from: \(selectedImage.imagePath)")
            imageView.image = UIImage(contentsOfFile: selectedImage.imagePath)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}

//
//  DetailViewController.swift
//  app-from-scratch-01
//
//  Created by Júlio Bragança on 10/04/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func shareTapped() {
        let message = "take a look at this flag!"
        
        let vc2 = UIActivityViewController(activityItems: [message], applicationActivities: [])
        vc2.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc2, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

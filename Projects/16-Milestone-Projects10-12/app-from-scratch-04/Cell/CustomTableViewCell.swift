//
//  CustomTableViewCell.swift
//  app-from-scratch-04
//
//  Created by Júlio Bragança on 06/05/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    static var identifier: String = "CustomTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(_ data: Image) {
        nameLabel.text = data.imageName
        previewImageView.image = UIImage(contentsOfFile: data.imagePath)
    }
    
}

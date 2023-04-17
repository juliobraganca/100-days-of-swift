//
//  ViewController.swift
//  Project 06b
//
//  Created by Júlio Bragança on 16/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false // we have to do  our constraints by hand
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit() // sized to fit their content
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1) // to show in the screen
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = ["label1": label1,
                               "label2": label2,
                               "label3": label3,
                               "label4": label4,
                               "label5": label5]
        
        
        // MARK: Visual Format Language (VFL)
        
        for label in viewsDictionary.keys {
            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
            // The H: parts means that we're defining a horizontal layout
            // The pipe symbol, |, means "the edge of the view."
            // "H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view."
        }
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
            // The V: parts means that we're defining a vertical layout
            // The new thing in the VFL this time is the - symbol, which means "space". It's 10 points by default, but you can customize it.
            // Note that our vertical VFL doesn't have a pipe at the end, so we're not forcing the last label to stretch all the way to the edge of our view. This will leave whitespace after the last label, which is what we want right now.
        
    }


}


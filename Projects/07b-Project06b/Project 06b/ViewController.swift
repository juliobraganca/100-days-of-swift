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
        
// MARK: Visual Format Language (VFL)
//        let viewsDictionary = ["label1": label1,
//                               "label2": label2,
//                               "label3": label3,
//                               "label4": label4,
//                               "label5": label5]
//
//
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//            // The H: parts means that we're defining a horizontal layout
//            // The pipe symbol, |, means "the edge of the view."
//            // "H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view."
//        }
//
//        let metrics = ["labelHeight": 88] // it's better to use metris instead of saying the height for each element.
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
//            // The V: parts means that we're defining a vertical layout
//            // the - symbol means "space". It's 10 points by default, but you can customize it.
//            // Constraint priority is a value between 1 and 1000, where 1000 means "this is absolutely required" and anything less is optional. we're going to make the label height have priority 999 (i.e., very important, but not required) and all of the rest heights will the the same as label 1 so they are not different in the screen.
//            // Note that our vertical VFL doesn't have a pipe at the end, so we're not forcing the last label to stretch all the way to the edge of our view. This will leave whitespace after the last label, which is what we want right now.
//

        
        //MARK: Using Anchors
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.16, constant: 10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
}


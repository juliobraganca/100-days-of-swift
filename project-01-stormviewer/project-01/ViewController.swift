//
//  ViewController.swift
//  project-01
//
//  Created by Júlio Bragança on 02/04/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]() // That pictures array will be created when the ViewController screen is created, and exist for as long as the screen exists. It will be empty, because we haven’t actually filled it with anything, but at least it’s there ready for us to fill.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default // declares a constant called fm and assigns it the value returned by FileManager.default. This is a data type that lets us work with the filesystem, and in our case we'll be using it to look for files.
        let path = Bundle.main.resourcePath! // declares a constant called path that is set to the resource path of our app's bundle (a directory containing our compiled program and all our assets). So, this line says, "tell me where I can find all those images I added to my app."
        let items = try! fm.contentsOfDirectory(atPath: path) // declares a third constant called items that is set to the contents of the directory at a path. Which path? Well, the one that was returned by the line before. As you can see, Apple's long method names really does make their code quite self-descriptive! The items constant will be an array of strings containing filenames.
        
        for item in items { // we'll have the first filename ready to work with, and it'll be called item.
            if item.hasPrefix("nssl") { //To decide whether it's one we care about or not, we use the hasPrefix() method
                pictures.append(item) // add to the pictures array all the files we match inside our loop.
            }
            
        }
        
        print(pictures)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

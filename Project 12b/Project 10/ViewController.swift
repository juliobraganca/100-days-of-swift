//
//  ViewController.swift
//  Project 10
//
//  Created by Júlio Bragança on 28/04/23.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
            }
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // link for the following code: https://www.hackingwithswift.com/read/10/4/importing-photos-with-uiimagepickercontroller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString // generates a Universally Unique Identifier and is perfect for a random filename.
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) { // from 0 to 1 (highest possible)
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "What action do you want to take?", message: nil, preferredStyle: .alert)
        
        let rename = UIAlertAction(title: "Rename", style: .default) { action in
            let acRename = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            acRename.addTextField()
            
            acRename.addAction(UIAlertAction(title: "OK", style: .default) {[weak self, weak acRename] _ in
                guard let newName = acRename?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            })
            
            acRename.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(acRename, animated: true)
        }
        
        let delete = UIAlertAction(title: "Delete", style: .default) { action in
            let acDelete = UIAlertController(title: "Delete person", message: nil, preferredStyle: .alert)
            
            acDelete.addAction(UIAlertAction(title: "Delete", style: .default) { action in
                self.people.remove(at: indexPath.item)
                self.collectionView.reloadData()
            })
            
            acDelete.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(acDelete, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(rename)
        ac.addAction(delete)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
}


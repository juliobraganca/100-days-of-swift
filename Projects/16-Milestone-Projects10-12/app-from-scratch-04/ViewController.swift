//
//  ViewController.swift
//  app-from-scratch-04
//
//  Created by Júlio Bragança on 06/05/23.
//

import UIKit

class ViewController: UITableViewController {
    
    let testArr = ["test1", "test2", "test3", "test4"]
    var pictures: [Image] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        title = "Uploaded Images"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
    }
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell
        cell?.setupCell(pictures[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedImage = pictures[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = selectedImage
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func addImage(){
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let randomImageName = "\(UUID().uuidString).jpeg" // Append .jpeg extension to the filename
        let imagePath = Bundle.main.documentsDirectory.appendingPathComponent(randomImageName) // Construct the path
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath) // Save the image data to the constructed path
        }
        
        dismiss(animated: true) // Dismiss the image picker
        
        showNameAlert(forImage: randomImageName) // This can be used to give a user-friendly name if needed but isn't essential for the saving/loading mechanism
    }

    
    func showNameAlert(forImage image: String) {
        let nameAlert = UIAlertController(title: nil, message: "What would you like the picture name to be?", preferredStyle: .alert)
        
        nameAlert.addTextField()
        nameAlert.addAction(
            UIAlertAction(title: "Ok", style: .default) { [weak self, weak nameAlert] _ in
                guard let name = nameAlert?.textFields?.first?.text else { return }
                
                let image = Image(imageName: name, imageFileName: image)
                self?.pictures.append(image)
                
                self?.savePhotoEntries()
            }
        )
        
        present(nameAlert, animated: true)
    }
    
    func savePhotoEntries() {
        DispatchQueue.global().async { [weak self] in
            guard let pictures = self?.pictures else { return }
            
            if let savedPictures = try? JSONEncoder().encode(pictures) {
                UserDefaults.standard.set(savedPictures, forKey: "photoEntries")
            } else {
                print("Failed to save photo entries.")
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


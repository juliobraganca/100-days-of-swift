//
//  ViewController.swift
//  app-from-scratch-02
//
//  Created by Júlio Bragança on 18/04/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear list", style: .plain, target: self, action: #selector(clearList))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func newItem() {
        let ac = UIAlertController(title: "Enter Shopping Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitItem = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let listItem = ac?.textFields?[0].text else { return }
            self?.submitItem(listItem)
        }
        
        ac.addAction(submitItem)
        present(ac, animated: true)
    }
    
    func submitItem(_ listItem: String) {
        shoppingList.insert(listItem, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
    @objc func clearList() {
        
        let ac = UIAlertController(title: "Clear list", message: "Are you sure you want to clear your shopping list?", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            self.shoppingList.removeAll(keepingCapacity: true)
            self.tableView.reloadData()
        }
        ac.addAction(OKAction)
        ac.addAction(UIAlertAction(title: "No", style: .cancel))
        self.present(ac, animated: true)
    }
    
}

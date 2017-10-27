//
//  PairOfPeopleTableViewController.swift
//  FinalTest
//
//  Created by Brian Licea on 10/27/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import UIKit

class PairOfPeopleTableViewController: UITableViewController {
   @IBAction func addPerson(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list", preferredStyle: .alert)
    alert.addTextField { (textField:UITextField) in
        textField.placeholder = "Full Name"
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let addAction = UIAlertAction(title: "Add", style: .default) { (action: UIAlertAction) in
        if let firstTextField = alert.textFields?.first {
            if firstTextField.text == "" {
                print("Please enter a name.")
            }else{
                if let newPersonName = firstTextField.text {
                    PersonController.shared.addPerson(withName: newPersonName)
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
    }
    alert.addAction(addAction)
    alert.addAction(cancelAction)
    
    self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        PersonController.shared.pairOfPeople = PersonController.shared.randomize(PersonController.shared.people)
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sectionCount = PersonController.shared.pairOfPeople.count
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.pairOfPeople[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.cell, for: indexPath)
        let cellName = PersonController.shared.pairOfPeople[indexPath.section][indexPath.row].name
        cell.textLabel?.text = "\(cellName)"
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}

//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Tran Minh Thy on 29/5/17.
//  Copyright © 2017 Tran Minh Thy. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDegelate {
    
    var dataModel: DataModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return dataModel.lists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = makeCell(for: tableView)
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    func makeCell(for tableView: UITableView) -> UITableViewCell{
        let cellIdentifier = "Cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            return cell
        }
        else{
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let checklist = dataModel.lists[indexPath.row]
        print("Checklist name is \(checklist.name)")
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ShowChecklist"{
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as! Checklist
            
        }else if segue.identifier == "AddChecklist"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.index(of: checklist)
        {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = checklist.name
            }
        }
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath){
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "ListDetailNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        present(navigationController, animated: true, completion: nil)
    }
   }

//
//  NotesListViewController.swift
//  Notepad
//
//  Created by Matteo Pasotti on 24/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import UIKit
import CoreData

class NotesListViewController: UITableViewController {
    
    var notes = [Note]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadNotes()
        
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Write a note", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if let message = alert.textFields?[0].text {
                let note = Note(context: self.context)
                note.body = message
                self.notes.append(note)
                self.saveNotes()
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write a note"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = note.body
        
        return cell
    }

    // MARK: - Table View delegate methods
    
    
    // MARK: - DB Methods
    func saveNotes() {
        do {
            try context.save()
            
        } catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadNotes(with request: NSFetchRequest<Note> = Note.fetchRequest()){
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error fetchin data from context, \(error)")
        }
        
        tableView.reloadData()
    }

}

// MARK: - Search Bar methods
extension NotesListViewController: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

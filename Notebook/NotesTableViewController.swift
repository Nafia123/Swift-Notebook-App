//
//  NotesTableViewController.swift
//  Notebook
//
//  Created by Naw on 22/01/2022.
//


import UIKit

class NoteTableViewController: UITableViewController {

    var notebookObject:Notebook? {
        didSet {
            self.configureView()
        }
    }
    
    var notesArray = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configureView () {
        self.navigationItem.title = notebookObject?.title
        loadData()
    }
    
    func loadData(){
        if let notebook = notebookObject {
            if let notes = NotesManager.shared.getNotes(notebook) {
                notesArray = notes
                self.tableView.reloadData()
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let noteObject = notesArray[indexPath.row]
        
        cell.textLabel?.text = noteObject.content

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = self.complete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [complete])
        return swipe
    }
    
    private func complete(rowIndexPathAt indexPath: IndexPath) ->
    UIContextualAction{
        let action = UIContextualAction(style: .normal, title: "Complete") {[weak self] (_,_,_) in
            
        
        }
        action.backgroundColor = .green
        return action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let noteVC = segue.destination as! NoteViewController
        noteVC.notebookObject = notebookObject
        noteVC.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        if segue.identifier == "showNoteSegue" {
            if let selectedNoteIndexPath = self.tableView.indexPathForSelectedRow {
                let noteObject = notesArray[selectedNoteIndexPath.row]
                noteVC.noteObject = noteObject
            }
        }
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            let noteObjectToDelete = notesArray[indexPath.row]
            NotesManager.shared.deleteNote(noteObjectToDelete)
            notesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


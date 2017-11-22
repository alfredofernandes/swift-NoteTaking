//
//  ViewController.swift
//  NoteTaking
//
//  Created by Alfredo Fernandes on 2017-11-21.
//  Copyright © 2017 Alfredo Fernandes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var data: [String] = []
    var selectedRow: Int = -1
    var file: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title
        self.title = "Notes"
        
        // Add Button Item
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        
        // Edit Button Item
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        // Saving on the File
        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docsDir[0].appending("/notes.txt")
        
        loadData()
    }
    
    // addNote
    @objc func addNote() {
        
        // Avoid to add notes if is editing
        if (table.isEditing) {
            return
        }
        
        let name: String = "Item \(data.count + 1)"
        data.insert(name, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [indexPath], with: .automatic)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    // setEditing
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    // deleteRows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        
        saveData()
    }
    
    // saveData
    func saveData() {
        // File
        let newData: NSArray = NSArray(array: data)
        newData.write(toFile: file, atomically: true)
        
        // UserDefaults
        //UserDefaults.standard.set(data, forKey: "Notes")
        //UserDefaults.standard.synchronize()
    }
    
    // loadedData
    func loadData() {
        // File
        if let loadedData = NSArray(contentsOfFile: file) as? [String] {
            data = loadedData
            table.reloadData()
        }
        
        // UserDefaults
        //if let loadedData = UserDefaults.standard.value(forKey: "Notes") as? [String] {
        //    data = loadedData
        //    table.reloadData()
        //}
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    // prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: DetailViewController = segue.destination as! DetailViewController
        selectedRow = table.indexPathForSelectedRow!.row
        detailView.setText(t: data[selectedRow])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


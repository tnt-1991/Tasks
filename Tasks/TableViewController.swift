//
//  TableViewController.swift
//  Tasks
//
//  Created by Kirill Klimovich on 09/06/2018.
//  Copyright © 2018 Kirill Klimovich. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var dateFormatter = DateFormatter()
    var events = [Event]()
    var datePickerIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tableView.register(TableViewCell.self, forCellReuseIdentifier: "EventCell")

        setDateFormatter()
        createEvents()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = events.count
        
        if datePickerIndexPath != nil {
            rows+=1
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if datePickerIndexPath != nil && datePickerIndexPath!.row == indexPath.row {
            cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell")!
            let datePicker = cell.viewWithTag(1) as! UIDatePicker // set the tag of Date Picker to be 1 in the Attributes Inspector
            let textField = cell.viewWithTag(2) as! UITextField
            let event = events[indexPath.row - 1]
            datePicker.setDate(event.deadline, animated: true)
            textField.text = event.title
        }
else {
            cell = tableView.dequeueReusableCell(withIdentifier: "EventCell")!
            let event = events[indexPath.row]
            cell.textLabel!.text = event.title
            cell.detailTextLabel!.text = dateFormatter.string(from: event.deadline)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight = tableView.rowHeight
        if datePickerIndexPath != nil && datePickerIndexPath!.row == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell")!
            rowHeight = cell.frame.height
        }
        return rowHeight
    }
    
    func createEvents() { // called in viewDidLoad()
        let event1 = Event(title: "Item 1", deadline: dateFormatter.date(from: "6/9/18")!)
        let event2 = Event(title: "Item 2", deadline: dateFormatter.date(from: "6/10/18")!)
        let event3 = Event(title: "Item 3", deadline: dateFormatter.date(from: "6/15/18")!)
   
        events.append(event1)
        events.append(event2)
        events.append(event3)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates() // because there are more than one action below
        if datePickerIndexPath != nil && datePickerIndexPath!.row - 1 == indexPath.row { // case 2
            tableView.deleteRows(at: [datePickerIndexPath!], with: .fade)
            datePickerIndexPath = nil
        } else { // case 1、3
            if datePickerIndexPath != nil { // case 3
                tableView.deleteRows(at: [datePickerIndexPath!], with: .fade)
            }
            datePickerIndexPath = calculateDatePickerIndexPath(indexPathSelected: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    func calculateDatePickerIndexPath(indexPathSelected: IndexPath) -> IndexPath {
        if datePickerIndexPath != nil && datePickerIndexPath!.row <= indexPathSelected.row { // case 3.2
            return IndexPath(row: indexPathSelected.row, section: 0)
        } else { // case 1、3.1
            return IndexPath(row: indexPathSelected.row + 1, section: 0)
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if datePickerIndexPath == nil{
        
        }
        //} && datePickerIndexPath!.row != indexPath.row {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        if datePickerIndexPath != nil {
            return UITableViewCellEditingStyle.none
        } else {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    //edit swipe action (left-side)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in success(true)
        })
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    @IBAction func changeDate(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: datePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = events[parentIndexPath.row]
        event.deadline = sender.date
        // change view
        let eventCell = tableView.cellForRow(at: parentIndexPath)!
        eventCell.detailTextLabel!.text = dateFormatter.string(from: sender.date)
    }
    @IBAction func changeTitle(_ sender: UITextField) {
        let parentIndexPath = IndexPath(row: datePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = events[parentIndexPath.row]
        event.title = sender.text!
        // change view
        let eventCell = tableView.cellForRow(at: parentIndexPath)!
        eventCell.textLabel!.text = sender.text
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController {
    func setDateFormatter() {
        dateFormatter.dateStyle = .short
    }
}

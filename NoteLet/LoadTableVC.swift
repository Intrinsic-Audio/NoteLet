//
//  LoadTableVC.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/10/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class LoadTableVC : UITableViewController , UITableViewDelegate, UITableViewDataSource {
    var compositions: [Composition]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compositions = Composition.MR_findAll() as [Composition]
        var numNotes = NoteEntity.MR_numberOfEntities()
        println("Notes: \(numNotes)")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return compositions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = compositions[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var predicate : NSPredicate = NSPredicate(format: "name == %@", compositions[indexPath.row].name)!
        
        var fetchRequest = Composition.MR_requestFirstWithPredicate(predicate)
        fetchRequest.returnsObjectsAsFaults = false
        
        var composition = Composition.MR_executeFetchRequestAndReturnFirstObject(fetchRequest) as Composition
            
//        var composition : Composition = Composition.MR_findFirstByAttribute("name", withValue: compositions[indexPath.row].name) as Composition
        
        println("\(composition.name)")
        
        var storyboard = UIStoryboard(name: "Instrument", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as InstrumentViewController
        controller.composition = composition
        controller.initNotes()
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
}
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
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }
    
//    func tableView(tableView: UITableView,
//        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
//        forRowAtIndexPath indexPath: NSIndexPath) {
//            if editingStyle == .Delete {
//                detailEntites.removeAtIndex(indexPath.row).deleteEntity()
//                NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
//                tableView.reloadData()
//            }
//    }
}
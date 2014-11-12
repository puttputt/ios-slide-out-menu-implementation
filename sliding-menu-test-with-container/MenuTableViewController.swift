//
//  MenuTableViewController.swift
//  sliding-menu-test-with-container
//
//  Created by Kyle Smyth on 2014-11-12.
//  Copyright (c) 2014 Kyle Smyth. All rights reserved.
//

import UIKit

protocol MenuDelegate {
    func itemSelected(item : Int)
}

class MenuTableViewController: UITableViewController {

    var delegate : MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setDelegate(delegate : MenuDelegate) {
        self.delegate = delegate
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if(indexPath.item == 0) {
            cell.textLabel.text = "Blue Controller"
        }
        else if (indexPath.item == 1) {
            cell.textLabel.text = "Red Controller"
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.itemSelected(indexPath.item)
    }
}

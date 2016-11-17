//
//  StoresListViewController.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 10/09/16.
//  Copyright © 2016 harman. All rights reserved.
//

import UIKit

class StoresListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let shopArray   =   ["Electronic Shop", "The Mall", "Online shoppe", "My Local grocery", "Big Dukaan", "Best Apparels", "Something more", "The best jeans", "TV 18 Shop", "Neelkanth Stores"]
    var selectedShop:String =   ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shopArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.backgroundColor    =   UIColor.purpleColor()
        cell.textLabel?.text    = shopArray[indexPath.row]
        cell.textLabel?.font    =   UIFont.boldSystemFontOfSize(14)
        cell.detailTextLabel?.text  =   "Address: Ecospace, Outer Ring Road, Bellandur, Bengaluru, Karnataka 560103"
        cell.detailTextLabel?.numberOfLines =   0
        cell.detailTextLabel?.textColor =   UIColor.magentaColor()
        cell.imageView?.image   =   UIImage(named:(String(format:"images-%d",indexPath.row)))
        

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedShop   =   shopArray[indexPath.row]
        self.performSegueWithIdentifier("LSTShop", sender: self);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Make sure your segue name in storyboard is the same as this line
        if (segue.identifier == "LSTShop"){
            // Get reference to the destination view controller
            let vc  = segue.destinationViewController as! StoreAndProductViewController
            vc.title =   self.selectedShop
        }
    }
}

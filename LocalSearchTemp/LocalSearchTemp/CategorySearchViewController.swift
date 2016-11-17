//
//  CategorySearchViewController.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 04/09/16.
//  Copyright © 2016 harman. All rights reserved.
//

import UIKit

class CategorySearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: Properties
    @IBOutlet weak var tableView:UIExpandableTableView!

    var selectedCity: String    =   ""
    let headerTitle =   ["Category of item", "Filter by"];
    let categoryOfItems     =   ["Apparel", "Shoes", "Jwellery", "Handloom", "Specs"]
    let filterOptions       =   ["Category", "Brand", "New Arrival", "Price", "Size", "Discount"]
    var detailDict:[String: [String]]!
    var selectedDetails:NSMutableDictionary =   NSMutableDictionary()
    
    //MARK: view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         detailDict  =   [headerTitle[0]:categoryOfItems, headerTitle[1]:filterOptions]
        
        selectedDetails =   ["SelectedCity":self.selectedCity, "SelectedCategory":"", "SelectedFilter":""]
        
        let rightBarButton  =   UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(nextScreen(_:)))
        
        self.navigationItem.setRightBarButtonItem(rightBarButton, animated: true)

    }
    
    func nextScreen(sender:UIBarButtonItem) {
        
        let selectedCat = self.selectedDetails["SelectedCategory"] as! String
        let selectedFilter = self.selectedDetails["SelectedFilter"] as! String
        
        if selectedCat.characters.count>0 && selectedFilter.characters.count>0 {
            self.performSegueWithIdentifier("LSTShopList", sender: self);
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Make sure your segue name in storyboard is the same as this line
        if (segue.identifier == "LSTShopList"){
            // Get reference to the destination view controller
            LSTUserProfile.sharedInstance.selectedFilters   =   self.selectedDetails
            let vc  = segue.destinationViewController as! StoresListViewController
            vc.title =   "\(self.selectedCity)"
        }
    }

    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return detailDict.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!detailDict.isEmpty) {
            if (self.tableView.sectionOpen != NSNotFound && section == self.tableView.sectionOpen) {
                return detailDict[headerTitle[section]]!.count
            }
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.backgroundColor    =   UIColor.purpleColor()
        cell.textLabel?.text    = detailDict[headerTitle[indexPath.section]]![indexPath.row]
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(tableView: self.tableView, section: section)

        
        headerView.backgroundColor  =   UIColor.grayColor()
        let label = UILabel(frame: headerView.frame)
//        if section==0 {
//            label.text =    String (format: "%@ %@", headerTitle[section], selectedCity)
//        }else{
            label.text =    String (format: "%@", headerTitle[section])
//        }
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.whiteColor()
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var prevSelection:Int!
        
        
        switch indexPath.section {
        case 0:
            prevSelection = categoryOfItems.indexOf(selectedDetails["SelectedCategory"]! as! String)
        default:
            prevSelection = categoryOfItems.indexOf(selectedDetails["SelectedFilter"]! as! String)
        }
        
        if !(prevSelection==nil) {
            let prevIndex       =   NSIndexPath(forRow:prevSelection, inSection:indexPath.section)
            let prevCell    =   tableView.cellForRowAtIndexPath(prevIndex)
            prevCell?.accessoryType =   UITableViewCellAccessoryType.None
        }
        
        let cell    =   tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType =   UITableViewCellAccessoryType.Checkmark
        
        switch indexPath.section {
        case 0:
            selectedDetails["SelectedCategory"] =   categoryOfItems[indexPath.row]
        default:
            selectedDetails["SelectedFilter"]   =   categoryOfItems[indexPath.row]
        }

       // tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

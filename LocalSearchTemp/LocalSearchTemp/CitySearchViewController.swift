//
//  CitySearchViewController.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 20/08/16.
//  Copyright © 2016 harman. All rights reserved.
//

import UIKit


class CitySearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredCities : [String] = []
    var cityList: [String] = ["Bangalore", "Indore", "Bhopal","New Delhi", "Mumbai", "Hyderabad","Pune", "Vizag", "Nagpur","Chennai", "Trivandrum", "Delhi","Raipur", "Shimla", "Dehradun"]
    var searchActive : Bool = false
    var selectedCity : String = ""
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        let classString     =   #file.componentsSeparatedByString("/").last!
//        NSLog("\n Class %@  \n Column %d  \n Function  %@   \n Line %d", classString, #column, #function, #line)
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if (LSTUserProfile.sharedInstance.userName.characters.count>0) {
            self.navigationItem.title   =   LSTUserProfile.sharedInstance.firstName
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:    UITableViewDataSource
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredCities.count
        }
        return self.cityList.count
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("Cell" as String!)! as UITableViewCell!

        cell.backgroundColor    =   UIColor.purpleColor()
        if searchActive {
            cell.textLabel?.text  = filteredCities[indexPath.row]
        } else {
            cell.textLabel?.text  = cityList[indexPath.row]
        }
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searchActive {
            self.selectedCity   =   filteredCities[indexPath.row]
        } else {
            self.selectedCity   =   cityList[indexPath.row]
        }
        self.performSegueWithIdentifier("LSTFilter", sender: self);
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Make sure your segue name in storyboard is the same as this line
        if (segue.identifier == "LSTFilter"){
            // Get reference to the destination view controller
            let vc  = segue.destinationViewController as! CategorySearchViewController
            vc.selectedCity =   self.selectedCity
        }
    }
    
    
    //MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCities = cityList.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredCities.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
}




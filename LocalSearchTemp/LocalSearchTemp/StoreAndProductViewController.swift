//
//  StoreAndProductViewController.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 11/09/16.
//  Copyright © 2016 harman. All rights reserved.
//

import UIKit
import SwiftCarousel
import CoreLocation
import MapKit

class StoreAndProductViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var carousel: SwiftCarousel!
    @IBOutlet weak var selectedTextLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    var items: [String]?
    var itemsViews: [UIImageView]?
    var textField: UITextField?
    var selectedItem:String!

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.purpleColor()
        items = ["Nike", "Addidas", "Woodlands", "Redtape", "Action", "Puma"]
        itemsViews = items!.map { imageForString($0) }
        carousel.items = itemsViews!
        carousel.resizeType = .VisibleItemsPerPage(3)
        carousel.defaultSelectedIndex = 3 // Select default item at start
        carousel.delegate = self
    }
    
    func imageForString(string: String) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: string)
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        
        return imageView
    }

    
    // MARK: -
    //MARK: Button Actions
    
    @IBAction func selectCurrentProduct() {
        carousel.selectItem(1, animated: true)
    }
    
    @IBAction func showAddress() {
        let coordinate = CLLocationCoordinate2DMake(22.719569,75.857726)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func makeCallToOwner() {
        if let url = NSURL(string: "tel://9981828387") {
            if UIApplication.sharedApplication().canOpenURL(url) {
                UIApplication.sharedApplication().openURL(url)
            }else{
                let alert = UIAlertController(title: "Cannot Make Call!!!",
                                              message: "Please check if your phone has sim or is in network",
                                              preferredStyle:UIAlertControllerStyle.Alert)
               // defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
               // handler:^(UIAlertAction * action) {}];
                
                let defaultAction = UIAlertAction.init(title: "OK",
                                                   style: UIAlertActionStyle.Default,
                                                   handler: nil)
                
                alert.addAction(defaultAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func orderNow() {

        let alert = UIAlertController(title: "Order Accepted!",
                                      message: "How would you like to pay for order?",
                                      preferredStyle:UIAlertControllerStyle.Alert)
        
//        alert.addAction(UIAlertAction(title: "Online", style: UIAlertActionStyle.Default, handler:nil))
        alert.addAction(UIAlertAction(title: "Cash On Delivery", style: UIAlertActionStyle.Default, handler:nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func addToCart () {
        
        if (self.favoriteButton.tag == 0) {
            self.favoriteButton.setTitle("Remove from cart", forState: UIControlState.Normal)
            self.favoriteButton.titleLabel!.textColor  =   UIColor.redColor()
            self.favoriteButton.tag = 1
            LSTUserProfile.sharedInstance.cart.addObject(self.selectedItem)
        }else{
            self.favoriteButton.setTitle("Add to cart", forState: UIControlState.Normal)
            self.favoriteButton.titleLabel!.textColor  =   UIColor.blueColor()
            self.favoriteButton.tag = 0
            LSTUserProfile.sharedInstance.cart.removeObject(self.selectedItem)
        }
    }
    
    
    @IBAction func WriteReview() {
        
        let alert = UIAlertController(title: "REVIEW",
                                      message: "Please share your honest reviews.",
                                      preferredStyle:UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(nil)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
//            print("User click Ok button")
//            print(self.textField!.text)
        }))
        
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })
        
    }

    
// MARK: -
    
//    func configurationTextField(textField: UITextField!)
//    {
//        if textField != nil {
//            textField.text = ""
//        }
//    }
}

extension StoreAndProductViewController: SwiftCarouselDelegate {
    
    func didSelectItem(item item: UIView, index: Int, tapped: Bool) -> UIView? {
        if let product = item as? UIImageView {
            product.layer.borderColor = UIColor.greenColor().CGColor
            product.layer.borderWidth = 3

            self.selectedItem  =   self.items![index]
//            let userCart =   LSTUserProfile.sharedInstance.cart.indexOfObject(currentProduct)
            
            if (LSTUserProfile.sharedInstance.cart?.indexOfObject(self.selectedItem) != NSNotFound ) {
                self.favoriteButton.setTitle("Remove from cart", forState: UIControlState.Normal)
                self.favoriteButton.titleLabel!.textColor  =   UIColor.redColor()
                self.favoriteButton.tag = 1
            }else{
                self.favoriteButton.setTitle("Add to cart", forState: UIControlState.Normal)
                self.favoriteButton.titleLabel!.textColor  =   UIColor.blueColor()
                self.favoriteButton.tag = 0
            }
            
            selectedTextLabel.text = "\(items![index]) shoes size \(Int(arc4random_uniform(10))) \n \(Int(arc4random_uniform(100)))% discount"
            
            return product
        }
      
        return item
    }
    
    func didDeselectItem(item item: UIView, index: Int) -> UIView? {
        if let product = item as? UIImageView {
            product.layer.borderColor = UIColor.blackColor().CGColor
            
            return product
        }
        
        return item
    }
    
    func didScroll(toOffset offset: CGPoint) {
       // selectedTextLabel.text = "Spinning up!"
    }
    
    func willBeginDragging(withOffset offset: CGPoint) {
        selectedTextLabel.text = "Drag to see other product"
    }
    
    func didEndDragging(withOffset offset: CGPoint) {
        //selectedTextLabel.text = "Oh, here we go!"
    }
}

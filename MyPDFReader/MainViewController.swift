//
//  MainViewController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 8/3/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewControllerIdentifiers = ["collectionController", "tableController"]
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Style
        let golbalGreen: UIColor = UIColor(red: 33 / 255.0, green: 197 / 255.0, blue: 180 / 255.0, alpha: 0.5)
        
        self.view.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
        
        self.navigationController?.navigationBar.barTintColor = golbalGreen
        self.navigationController?.toolbar.barTintColor = golbalGreen
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Collection view / Table view switch  */
    @IBAction func indexChanged(sender: UISegmentedControl) {
        let newController = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[sender.selectedSegmentIndex]) as UIViewController!
        let oldController = childViewControllers.last as UIViewController!
        
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        
        transitionFromViewController(oldController, toViewController: newController, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in }, completion: { (finished) -> Void in
            oldController.removeFromParentViewController()
            newController.didMoveToParentViewController(self)
        })
    }
    
    /* Import the pdf document */
    @IBAction func importPDFDocuments(sender: AnyObject) {
        print("Import the pdf document")
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

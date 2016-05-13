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
        
        // local data example
        let banStr = "左边\"舟\"字短撇有力，竖弧撇起笔藏锋，向下运行一半后向左弯，收笔时向左下撇出，势微曲婉，力勻饱满。右边的\"文\"字捺脚有力，隶意十足。"
        let shiStr = "上部的斜撇运笔写法是：起笔轻按，提笔向左下运行，出锋微带曲势，下行时由重渐轻，腕同时翻向左方，用腕力将锋送出，空中收笔。上部的捺写成点势，覆盖下面的\"良\"，字体舒展大方。"
        let boStr = "三点水成一弧形，映带右边的\"皮\"字。末笔斜捺粗壮，写法是尖锋入纸，向右下运行，逐渐加重笔力，笔毫顺势铺开，出捺脚时略作停顿，向右捺出，状如军刀。"
        let ciStr = "两点水略小，\"欠\"字略大占主体。最后一笔反捺，尖锋入纸，向右下运行逐渐加重，收笔轻蹲。"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(banStr, forKey: "ban")
        defaults.setValue(shiStr, forKey: "shi")
        defaults.setValue(boStr, forKey: "bo")
        defaults.setValue(ciStr, forKey: "ci")
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

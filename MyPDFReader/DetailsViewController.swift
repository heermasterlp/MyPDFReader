//
//  DetailsViewController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 7/29/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var detailsWebView: UIWebView!
    @IBOutlet var previousPDFFileButton: UIBarButtonItem! // Previous pdf file button
    @IBOutlet var nextPDFFileButton: UIBarButtonItem! // Next pdf file button
    
    var fileName = ""
    var allPDFFiles: [String] = []
    var indexOfPDF = 0 // The index of pdf file
    
    // Gesture paramers
    var lastScaleFactor: CGFloat! = 1 // Enlarge or redcue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture
        // Pinch gesture
        var pinchGesture = UIPinchGestureRecognizer(target: self, action: "handlePinchGesture:")
        self.view.addGestureRecognizer(pinchGesture)
        
        // Swipe gesture
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipeGesture:")
        self.view.addGestureRecognizer(swipeGesture)
        
        // Style 
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.purpleColor()]
        // Display the pdf file
        displayPDFFile()
        
        // The initial status of previous/next button
        if indexOfPDF == 0 {
            self.previousPDFFileButton.enabled = false
            self.nextPDFFileButton.enabled = true
        }
        
        if indexOfPDF == allPDFFiles.count - 1 {
            self.nextPDFFileButton.enabled = false
            self.previousPDFFileButton.enabled = true
        }
        
    }
    
    // Load and display the pdf file
    func displayPDFFile() {
        
        // Set the title of view controller
        self.title = "\(allPDFFiles[indexOfPDF] as String ) (\(self.indexOfPDF + 1) / \(self.allPDFFiles.count))"
        
        
        // load the pdf file
        if let pdfPath = NSBundle.mainBundle().pathForResource(allPDFFiles[indexOfPDF], ofType: "pdf"){
            
            let pdfUrl = NSURL.fileURLWithPath(pdfPath)
            self.detailsWebView.loadRequest(NSURLRequest(URL: pdfUrl!))
        }
        
    }
    
   
    // Previous pdf file
    @IBAction func previousPDFFileClicked(sender: UIBarButtonItem) {
        nextPDFFileButton.enabled = true
        if self.indexOfPDF > 0 {
            self.indexOfPDF--
        }
        if self.indexOfPDF == 0 {
            previousPDFFileButton.enabled = false
        } else {
            previousPDFFileButton.enabled = true
        }
        displayPDFFile()
    }
    
    // Next pdf file
    @IBAction func nextPDFFileClicked(sender: UIBarButtonItem) {
        previousPDFFileButton.enabled = true
        if self.indexOfPDF < self.allPDFFiles.count - 1 {
            self.indexOfPDF++
        }
        if self.indexOfPDF == self.allPDFFiles.count - 1 {
            nextPDFFileButton.enabled = false
        } else {
            nextPDFFileButton.enabled = true
        }
        displayPDFFile()
    }
    
    /* The gesture function */
    
    // Handle the pinch gesture
    func handlePinchGesture(gesture: UIPinchGestureRecognizer){
        var factor = gesture.scale
        if factor > 1 {
            // Enlarge
            detailsWebView.transform = CGAffineTransformMakeScale(lastScaleFactor + factor - 1, lastScaleFactor + factor - 1)
        } else {
            detailsWebView.transform = CGAffineTransformMakeScale(lastScaleFactor * factor, lastScaleFactor * factor)
        }
        // Judge the state of webview to save the data
        if gesture.state == UIGestureRecognizerState.Ended {
            if factor > 1 {
                lastScaleFactor = lastScaleFactor + factor - 1
            } else {
                lastScaleFactor = lastScaleFactor * factor
            }
        }
    }
    
    // handle the swipe gesture
    func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        var direction = gesture.direction
        switch direction {
        case UISwipeGestureRecognizerDirection.Left:
            if self.indexOfPDF == allPDFFiles.count - 1 {
                self.indexOfPDF = 0
            } else {
                self.indexOfPDF++
            }
        case UISwipeGestureRecognizerDirection.Right:
            if self.indexOfPDF == 0 {
                self.indexOfPDF = self.allPDFFiles.count - 1
            } else {
                self.indexOfPDF--
            }
        default:
            break
        }
        // Display the pdf file
        displayPDFFile()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  PDFCollectionViewController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 8/3/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

let reuseIdentifier = "pdfCollecCell"

class PDFCollectionViewController: UICollectionViewController,  UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var pdfCollectionView: UICollectionView! // Collections view
    
    
    
    
    
    var pdfFiles: [String] = [] // All pdf file name
    
    var filteredPDFFiles: [String] = [] // Filtered the pdf file name
    
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfCollectionView.delegate = self
        pdfCollectionView.dataSource = self
        
//        pdfSearchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        

        // Register cell classes
        self.pdfCollectionView!.registerClass(PDFCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        pdfFiles = PDFUtil.getListOfPDFFiles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Segure with paramers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PDFCollectionDetail" {
            
            let pdfcell = sender as! PDFCollectionCell
            
            let indexPath = pdfCollectionView.indexPathForCell(pdfcell)
            
            ((segue.destinationViewController) as! DetailsViewController).allPDFFiles = pdfFiles
            ((segue.destinationViewController) as! DetailsViewController).indexOfPDF = indexPath!.row
        }
    }
    
    
    @IBAction func importPDFFileFromSystem(sender: UIBarButtonItem) {
        
        println("This is the import pdf file function!")
        
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return searchActive ? filteredPDFFiles.count : pdfFiles.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PDFCollectionCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! PDFCollectionCell
        println("This is load cell")
        // Configure the cell
        // PDF file name
        
        let pdfName = searchActive ? filteredPDFFiles[indexPath.row] : pdfFiles[indexPath.row]
        
        if let label = cell.pdfLabel {
            label.text = pdfName
        }
        
        // Pdf file thumbnail image
        if let pdfPath = NSBundle.mainBundle().pathForResource(pdfName, ofType: "pdf") {
            let pdfUrl = NSURL.fileURLWithPath(pdfPath)

            if let pdfimage = cell.pdfImageView {
                pdfimage.image = PDFUtil.getThumbnail(pdfUrl!, pageNumber: 1)
            }
        }
        
        cell.backgroundColor = UIColor.blackColor()
    
        return cell
    }
    
    /* Search Bar Actions */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredPDFFiles = pdfFiles.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if filteredPDFFiles.count == 0 {
            searchActive = false
        } else {
            println("\(filteredPDFFiles.count)")
            searchActive = true
        }
        self.pdfCollectionView.reloadData()
    }
    
    // called when text starts editing
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
        println("begin edit true")
    }
    // called when text ends editing
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        println("end false")
    }
    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        println("search false")
    }
    // called when cancel button pressed
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        println("cancel false")
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

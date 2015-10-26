//
//  PDFCollectionController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 8/4/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

let reuseIdentifier = "pdfCollecCell"

class PDFCollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet var pdfCollectionView: UICollectionView!
    
    @IBOutlet var pdfSearchBar: UISearchBar!
    var pdfFiles: [String] = [] // All pdf file name
    
    var filteredPDFFiles: [String] = [] // Filtered the pdf file name
    
    var searchActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        pdfCollectionView.delegate = self
        pdfCollectionView.dataSource = self
        pdfSearchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Style
//        self.view.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.5)
        // Register cell classes
        self.pdfCollectionView!.registerClass(PDFCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        pdfFiles = PDFUtil.getListOfPDFFiles()    }
    
    // Segure with paramers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PDFCollectionDetail" {
            
            let pdfcell = sender as! PDFCollectionCell
            
            let indexPath = pdfCollectionView.indexPathForCell(pdfcell)
            
            ((segue.destinationViewController) as! DetailsViewController).allPDFFiles = filteredPDFFiles.count == 0 ? pdfFiles : filteredPDFFiles
            ((segue.destinationViewController) as! DetailsViewController).indexOfPDF = indexPath!.row
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchActive ? filteredPDFFiles.count : pdfFiles.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! PDFCollectionCell
        
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
                pdfimage.image = PDFUtil.getThumbnail(pdfUrl, pageNumber: 1)
            }
        }
        let cellBGColor = UIColor(red: 139 / 250.0, green: 76 / 250.0, blue: 57 / 250.0, alpha: 0.5)
        cell.backgroundColor = cellBGColor
        
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
            searchActive = true
        }
        self.pdfCollectionView.reloadData()
    }
    
    // called when text starts editing
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    // called when text ends editing
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        
    }
    // called when keyboard search button pressed
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        
    }
    // called when cancel button pressed
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
        
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

//
//  PDFCollectionViewController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 8/2/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

class PDFCollectionViewController: UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet var pdfCollectionView: UICollectionView!
    
    var pdfFiles: [String] = [] // All pdf file name
    var filteredPDFFiles:[String] = [] // Filtered the pdf file name
    
    var searchActive: Bool = false
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfCollectionView.dataSource = self
        pdfCollectionView.delegate = self
        // Get the	 list of pdf files in Document
        pdfFiles = PDFUtil.getListOfPDFFiles()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* The collections view function */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pdfFiles.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> PDFCollectionCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PDFCollectionCell", forIndexPath: indexPath) as! PDFCollectionCell
        
        // pdf file name
        let pdfName = pdfFiles[indexPath.row]
        cell.pdfNameLabel.text = pdfName
        // pdf file thumbnail image
        if let pdfPath = NSBundle.mainBundle().pathForResource(pdfName, ofType: "pdf"){
            
            let pdfUrl = NSURL.fileURLWithPath(pdfPath)
            cell.pdfThmImageView.image = PDFUtil.getThumbnail(pdfUrl!, pageNumber: 1)
        }

        
        cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    

}

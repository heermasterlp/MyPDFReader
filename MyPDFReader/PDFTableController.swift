//
//  PDFTableController.swift
//  MyPDFReader
//
//  Created by PeterLiu on 7/28/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

class PDFTableController: UITableViewController, UISearchBarDelegate {
    
    let fm = NSFileManager.defaultManager()
    
    let mainPath = NSBundle.mainBundle().resourcePath! // Documents directory

    var pdfFiles: [String] = [] // All pdf file name
    var filteredPDFFiles:[String] = [] // Filtered the pdf file name
    
    var searchActive: Bool = false
    
    @IBOutlet var tvPDFs: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Set up the delegates */
        searchBar.delegate = self
        
        // 1. Get the list of PDFs
        pdfFiles = PDFUtil.getListOfPDFFiles()
        
    }
    
    // Segure with paramers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "PDFFileContents" {
        
            let indexPath = tvPDFs.indexPathForSelectedRow!.row
            
            ((segue.destinationViewController) as! DetailsViewController).allPDFFiles = filteredPDFFiles.count == 0 ? pdfFiles : filteredPDFFiles
            ((segue.destinationViewController) as! DetailsViewController).indexOfPDF = indexPath
        }
    }
    
    // Import the pdf file from system
    @IBAction func importPDFButton(sender: UIBarButtonItem) {
        print("Add button is clicked!")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Get list of PDFs */
    func listPDFFiles() -> [String] {
        
        var result: [String] = []
        if let items = (try? fm.contentsOfDirectoryAtPath(mainPath)) as [String]! {
            for item in items {
                if item.hasSuffix("pdf") {
                    // Add the file name
                    result.append((item as NSString).substringWithRange(NSMakeRange(0, item.characters.count - 4)))
                }
            }
        } else {
            print("No pdf files existed!")
        }
        return result
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if searchActive {
            return filteredPDFFiles.count
        }
        return pdfFiles.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PDFViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PDFCell", forIndexPath: indexPath) as! PDFViewCell
        
        // Configure the cell...
        let pdfName = searchActive ? filteredPDFFiles[indexPath.row] : pdfFiles[indexPath.row] // each name of pdf file!
        
        cell.pdfLabel?.text = pdfName
        if let pdfPath = NSBundle.mainBundle().pathForResource(pdfName, ofType: "pdf"){
            
            let pdfUrl = NSURL.fileURLWithPath(pdfPath)
            cell.pdfThumbnailsImage.image = PDFUtil.getThumbnail(pdfUrl, pageNumber: 1)
        }
        let cellBGColor = UIColor(red: 33 / 250.0, green: 197 / 250.0, blue: 180 / 250.0, alpha: 0.1)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.whiteColor() : cellBGColor
        
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
        self.tvPDFs.reloadData()
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
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

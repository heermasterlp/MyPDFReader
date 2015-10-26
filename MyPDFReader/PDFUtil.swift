//
//  PDFUtil.swift
//  MyPDFReader
//
//  Created by PeterLiu on 8/2/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import Foundation
import UIKit

class PDFUtil {
    
    /* Get the thumbnails of pdf  */
    class func getThumbnail(url:NSURL, pageNumber:Int) -> UIImage {
        
        let pdf: CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url as CFURLRef)!
        
        let firstPage = CGPDFDocumentGetPage(pdf, pageNumber)
        
        // Change the width of the thumbnail here
        let width: CGFloat = 240.0
        
        var pageRect: CGRect = CGPDFPageGetBoxRect(firstPage, CGPDFBox.MediaBox)
        let pdfScale: CGFloat = width / pageRect.size.width
        pageRect.size = CGSizeMake(pageRect.size.width * pdfScale, pageRect.size.height * pdfScale)
        pageRect.origin = CGPointZero
        
        UIGraphicsBeginImageContext(pageRect.size)
        
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        // White BG
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(context, pageRect)
        
        CGContextSaveGState(context)
        
        // Next 3 lines makes the rorations so that the page look in the right direcitons
        CGContextTranslateCTM(context, 0.0, pageRect.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(firstPage, CGPDFBox.MediaBox, pageRect, 0, true))
        
        CGContextDrawPDFPage(context, firstPage)
        CGContextRestoreGState(context)
        
        let thm: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return thm
    }
    
    /* Get the list of pdf in the Document */
    class func getListOfPDFFiles() -> [String] {
        
        let fm = NSFileManager.defaultManager()
        
        let mainPath = NSBundle.mainBundle().resourcePath! // Documents directory
        
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

}
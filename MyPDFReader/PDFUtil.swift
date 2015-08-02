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
        
        var pdf: CGPDFDocumentRef = CGPDFDocumentCreateWithURL(url as CFURLRef)
        
        var firstPage = CGPDFDocumentGetPage(pdf, pageNumber)
        
        // Change the width of the thumbnail here
        var width: CGFloat = 240.0
        
        var pageRect: CGRect = CGPDFPageGetBoxRect(firstPage, kCGPDFMediaBox)
        var pdfScale: CGFloat = width / pageRect.size.width
        pageRect.size = CGSizeMake(pageRect.size.width * pdfScale, pageRect.size.height * pdfScale)
        pageRect.origin = CGPointZero
        
        UIGraphicsBeginImageContext(pageRect.size)
        
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        
        // White BG
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(context, pageRect)
        
        CGContextSaveGState(context)
        
        // Next 3 lines makes the rorations so that the page look in the right direcitons
        CGContextTranslateCTM(context, 0.0, pageRect.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(firstPage, kCGPDFMediaBox, pageRect, 0, true))
        
        CGContextDrawPDFPage(context, firstPage)
        CGContextRestoreGState(context)
        
        var thm: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return thm
    }

}
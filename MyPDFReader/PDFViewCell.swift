//
//  PDFViewCell.swift
//  MyPDFReader
//
//  Created by PeterLiu on 7/31/15.
//  Copyright (c) 2015 PeterLiu. All rights reserved.
//

import UIKit

class PDFViewCell: UITableViewCell {

    @IBOutlet var pdfThumbnailsImage: UIImageView!
    
    @IBOutlet var pdfLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

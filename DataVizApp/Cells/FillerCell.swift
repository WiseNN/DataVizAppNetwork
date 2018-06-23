//
//  FillerCell.swift
//  DataVizApp
//
//  Created by Norris Wise Jr on 6/22/18.
//  Copyright © 2018 SportsCollection. All rights reserved.
//

import UIKit
import SpreadsheetView
class FillerCell: Cell
{
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        layer.backgroundColor = appDelegate.borderColor.cgColor
//        self.backgroundColor = UIColor.purple
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borders.left = BorderStyle.solid(width: 5, color: appDelegate.borderColor)
        borders.right = BorderStyle.solid(width: 5, color: appDelegate.borderColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

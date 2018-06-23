//
//  DataCell.swift
//  DataVizApp
//
//  Created by Norris Wise Jr on 6/22/18.
//  Copyright © 2018 SportsCollection. All rights reserved.
//

import UIKit

import SpreadsheetView

//create cell for data cell of table
class DataCell: Cell
{
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //give appDelegate reference to dataCell
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.dataCell = self
        
        
        //make multi-line & scale to fit the cell
        label.numberOfLines = 0
        label.contentMode = .scaleAspectFit
        label.adjustsFontSizeToFitWidth = true
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.font = UIFont(name: "Avenir Next", size: 25)
        label.textAlignment = .center
        contentView.addSubview(label)
        
        
        let borderWidth : CGFloat = 0.5
        let borderColor = appDelegate.borderColor
        borders.right = BorderStyle.solid(width: borderWidth, color: borderColor)
        borders.left = BorderStyle.solid(width: borderWidth, color: borderColor)
        borders.top = BorderStyle.solid(width: borderWidth, color: borderColor)
        borders.bottom = BorderStyle.solid(width: borderWidth, color: borderColor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}

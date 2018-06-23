//
//  HeaderCell.swift
//  DataVizApp
//
//  Created by Norris Wise Jr on 6/22/18.
//  Copyright © 2018 SportsCollection. All rights reserved.
//

import UIKit
import SpreadsheetView

//create cell for header cell of table
class HeaderCell: Cell
{
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        borders.top = BorderStyle.solid(width: 2, color: appDelegate.borderColor)
        borders.top = BorderStyle.solid(width: 0, color: appDelegate.borderColor)
        borders.right = BorderStyle.solid(width: 2, color: appDelegate.borderColor)
        let lightGrey : CGFloat = 177/255
        let darkGrey : CGFloat = 90/255
        let colorL = UIColor.init(red: lightGrey, green: lightGrey, blue: lightGrey, alpha: 0.5)
        let colorD = UIColor.init(red: darkGrey, green: darkGrey, blue: darkGrey, alpha: 1)
        
        backgroundColor = colorL
        label.frame = bounds
        label.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = colorD
        label.textAlignment = .center
        contentView.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

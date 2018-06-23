//
//  DataTextFieldDelegate.swift
//  DataVizApp
//
//  Created by Norris Wise Jr on 6/22/18.
//  Copyright © 2018 SportsCollection. All rights reserved.
//

import UIKit

class DataTextFieldDelegate: NSObject, UITextFieldDelegate,UITextViewDelegate
{

    //for textField
    func textFieldDidEndEditing(_ textField: UITextField) {
        //get appDelegate share ref
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.spreadVC.isCellSelected = false
        appDelegate.spreadVC.mySpreadsheetView.isScrollEnabled = true
    }
    
    //for textView
    func textViewDidEndEditing(_ textView: UITextView) {
        //get appDelegate share ref
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.spreadVC.isCellSelected = false
        appDelegate.spreadVC.mySpreadsheetView.isScrollEnabled = true
    }
    
    
    //for textView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //get appDelegate share ref
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //check ascii value
        print("chars: \(text)")
        let code = text.unicodeScalars.first?.value
        print("char code: \(code ?? 090)")
        
        //if enter key, submit & remove textField
        if(code == 10)
        {
            
            
            //set the text on the schedule cell to the text in the textfield
            appDelegate.dataCell.label.text = textView.text
            
            //remove the textfield from the cell's content view
            appDelegate.dataCell.contentView.viewWithTag(987)?.removeFromSuperview()
            
            
            
            //update the datamodel with new text
            appDelegate.spreadVC.dataMatrix[appDelegate.indexPath.row-2][appDelegate.indexPath.column] = textView.text!
            return false
        }
        return true
    }
    
    
    
    
    
    
    //for textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        //get appDelegate share ref
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //check ascii value
        print("chars: \(string)")
        let code = string.unicodeScalars.first?.value
        print("char code: \(code ?? 090)")
        
        //if enter key, submit & remove textField
        if(code == 10)
        {
            
            //set the text on the schedule cell to the text in the textfield
            appDelegate.dataCell.label.text = textField.text
            
            //remove the textfield from the cell's content view
            appDelegate.dataCell.contentView.viewWithTag(987)?.removeFromSuperview()
            
            
            
            //update the datamodel with new text
            appDelegate.spreadVC.dataMatrix[appDelegate.indexPath.row-2][appDelegate.indexPath.column] = textField.text!
            return false
        }
        return true
    }
    
    
}

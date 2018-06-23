//
//  ViewController.swift
//  DataVizApp
//
//  Created by Norris Wise Jr on 6/21/18.
//  Copyright © 2018 SportsCollection. All rights reserved.
//

import UIKit
import SpreadsheetView

class ViewController: UIViewController, SpreadsheetViewDelegate, SpreadsheetViewDataSource
{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var mySpreadsheetView: SpreadsheetView!
    
 
    
    //appDelegate
    var appDelegate: AppDelegate!
    
    //textField delegate for scheduleCell
    let textfieldDelegate = DataTextFieldDelegate();
    var isCellSelected = false
    
    let numOfRows = 20
    let numOfColumns = 3
    
    let staticRowHeight : CGFloat = 80
    
    let numOfStaticRows = 2
    let numOfStaticColumns = 0
    
    let headerCelliD = "headerCell"
    let dataCelliD = "dataCell"
    let fillerCelliD = "fillerCell"
    
    //data model
    var dataMatrix : Array<Array<String>>!
    
    //create an array of dictionaries to keep track of the number of rows
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set appDelegate
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.spreadVC = self
        
        
        
        submitBtn.addTarget(self, action: #selector(self.clickHandler), for: UIControlEvents.touchUpInside)
        
        //setup data model (using in memory - data structure)
        dataMatrix = Array(repeating: Array(repeating: "", count:numOfColumns ), count: numOfRows)
        
        //assign spreadsheet dataSource & delegate
        mySpreadsheetView.dataSource = self
        mySpreadsheetView.delegate = self
    
//        //modify spreadsheet visual properties
        mySpreadsheetView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        mySpreadsheetView.intercellSpacing = CGSize(width: 0, height: 0)
        mySpreadsheetView.layer.borderColor = appDelegate.borderColor.cgColor
        mySpreadsheetView.layer.borderWidth = 2
        mySpreadsheetView.autoresizingMask = [.flexibleWidth, .flexibleHeight] //set auto resize widths
        
        
        
          //default grid style is no border, can do without for now
      mySpreadsheetView.gridStyle = .default
        
//        //register cells
        mySpreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: headerCelliD)
        mySpreadsheetView.register(DataCell.self, forCellWithReuseIdentifier: dataCelliD)
        mySpreadsheetView.register(FillerCell.self, forCellWithReuseIdentifier: fillerCelliD)
//
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //SpreadSheet DataSource methods
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 3
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return numOfRows
    }
    
    //row height
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        
        switch(row)
        {
        case 0 : return staticRowHeight // 50
        case 1 : return 3
            
        default:
            //add filler statement to default
            _ = ""
        }
        return staticRowHeight
    }
    
    //column width
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        //make each column 1/3 of spreadsheet width
        print("width layout")
        

        return (spreadsheetView.bounds.width/3)
    }
    
    
    //freeze two rows & zero columns at the top of spread sheet
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        
        
        
        return numOfStaticRows
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return numOfStaticColumns
    }
    
    
    //apply datasource to cell
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell?
    {
        print("indexPath \(indexPath)")
        
        //if first row
        if(indexPath.row == 0)
        {
            //deque header cell
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: headerCelliD, for: indexPath) as? HeaderCell
            
            
            //check if cell is nil, if so create new header cell...else, update cell and return
        
                switch(indexPath.column)
                {
                case 0: do {
                    cell!.label.text = "Name"
                }
                break;
                    
                case 1: do {
                    cell!.label.text = "Age"
                }
                break;
                    
                case 2: do {
                    cell!.label.text = "Speed"
                }
                break;
                    
                    
                default:
                    do {
                        print("NO CASES MATCH FOR CELL AT INDEX PATH")
                    }
                }
            return cell
        }
        else if(indexPath.row == 1)
        {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: fillerCelliD, for: indexPath)
            return cell;
        }else{
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: dataCelliD, for: indexPath) as! DataCell
            
            //ofset the row -2 because of static rows
            print("text: \(dataMatrix[indexPath.row-2][indexPath.column])")
            cell.label.text = dataMatrix[indexPath.row-2][indexPath.column]
            
            //if row is even, color with background
            let val = indexPath.row % 2
            if(val != 0)
            {
                let lightGrey : CGFloat = 177/255
             cell.backgroundColor = UIColor.init(red: lightGrey, green: lightGrey, blue: lightGrey, alpha: 0.3)
//                cell.backgroundColor = appDelegate.borderColor

            }else{
                cell.backgroundColor = UIColor.white
            }
            return cell
        }
    }
    
    
    @objc func clickHandler(sender: UIButton)
    {
        //if any text field is empty, ignore submission
        if( nameTextField.text!.isEmpty ||
            ageTextField.text!.isEmpty ||
            speedTextField.text!.isEmpty
        )
        {
            return
        }else{
            
            //add data to data matrix
            dataMatrix.append([nameTextField.text!, ageTextField.text!, speedTextField.text!])
//            spreadsheetView.reloadData()
        }
    }
    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath)
    {
        
        //get shared appDelegate
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //if static row, or cell is currently selected, ignore
        if(indexPath.row < 2 || isCellSelected)
        {
            return
        }
        
        //change isCellSelected to true (back to false -> only in the textFieldDelegate)
        isCellSelected = true
        //stop scroll while in edit mode (causes caching issues)
        appDelegate.spreadVC.mySpreadsheetView.isScrollEnabled = false
        
        //all else...
        //get the selected cell
        let cell = spreadsheetView.cellForItem(at: indexPath) as? DataCell
        
        //create textField to edit cell
        let myTextField = UITextField(frame: cell!.contentView.bounds)
        
        //set font
        myTextField.font = UIFont(name: "Avenir Next", size: 25)
        
//        myTextField.adjustsFontSizeToFitWidth = true
        myTextField.textAlignment = .center
        myTextField.layer.borderColor = UIColor.black.cgColor
        myTextField.layer.borderWidth = 1
        myTextField.layer.cornerRadius = 10
        myTextField.becomeFirstResponder() //give curser immediately (no double click)
        myTextField.text = cell?.label.text //make editable with current text from cell
        
        //set textfield delegate
        myTextField.delegate = textfieldDelegate
        
        //clear label text in cell to avoid duplicate drawing
        cell?.label.text = ""
        
        //share dataCell, indexPath ref's with appDelegate to update if needed
        appDelegate.dataCell = cell
        print("selected indexPath...row: \(indexPath.row) .... column: \(indexPath.column)")
        appDelegate.indexPath = indexPath
        
        //set tag on textField & cell to find later
        myTextField.tag = 987
        cell!.tag = 711
        
        //add label to subview
        cell!.contentView.addSubview(myTextField)
        
        
        
    }
    
    //stop cell selection if a cell is already in edit mode -> (isCellSelected = true)
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
        return !isCellSelected
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
//            self.spreadsheetView.setNeedsLayout()
//            self.spreadsheetView.layoutIfNeeded()
            self.mySpreadsheetView.reloadData()
            
            
        })
    }
    
    
    
    
    
    
    
    
    
    
   
    
    
}


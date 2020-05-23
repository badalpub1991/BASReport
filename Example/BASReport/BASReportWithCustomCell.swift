//
//  BASReportWithCustomCell.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import BASReport


class BASReportWithCustomCell: UIViewController {
    let  excelGreenColor = UIColor( red: CGFloat(41/255.0), green: CGFloat(88/255.0), blue: CGFloat(24/255.0), alpha: CGFloat(1.0) )
    let cellWidth:CGFloat = 150.0
    
    //Outlets
    @IBOutlet weak var basReport: BASCustomReport!
    //Variables
    var sampleData = [clockData]()
    var isAllChecked = false
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BASReport with CustomCell"
        registerDataSourceAndCell()
        initialSetup()
        
        // Do any additional setup after loading the view.
    }
    
    func registerDataSourceAndCell() {
        basReport.basReportDatasource = self
        basReport.arrCustomIndexPathForColumn = [0,3]
        basReport.basReportHeaderDatasource = self
        basReport.arrCustomHeaderSectionForColumn = [3]
        let customCellXIB = UINib(nibName: "tblCellWithImage", bundle: nil)
        let basReportCell:BASReportCustomCell = (customCellXIB,"tblCellWithImage")
        basReport.registerCellWithIdentifier(arrCustomCell: [basReportCell])
    }
    
    func initialSetup() {
        /* Set Header as! OrderedDictionary
         1) Object , Distance , Running etc set as Header
         2) Boolian value -> true if you want to set image , false if not set image
         and then pass it to BASReport
         */
        
        var HeaderDict = OrderedDictionary<String, Bool>()
        HeaderDict["Days of Month"] = false ;  HeaderDict["1:00"] = false ;HeaderDict["2:00"] = false ;HeaderDict["3:00"] = false ;HeaderDict["4:00"] = false; HeaderDict["5:00"] = false;HeaderDict["6:00"] = false;HeaderDict["7:00"] = false;HeaderDict["8:00"] = false;HeaderDict["9:00"] = false;HeaderDict["10:00"] = false;HeaderDict["11:00"] = false;HeaderDict["12:00"] = true
        self.basReport.arrGHeader = HeaderDict
        
        //*--------------------------------------------------------*//
        /* Set Layout as Layout class if you want to change layOut -> seperator color , seperator height , header text color , header height , font etc
         1) HeaderFont is for HeaderFont
         2) DataFont is for subCellFont
         */
        self.basReport.layoutSettings.setAllHeaderFont(font: UIFont(name: "Times New Roman", size: 17.0)!)
        self.basReport.layoutSettings.setAllDataFont(font: UIFont(name: "Times New Roman", size: 14.0)!)
        self.basReport.layoutSettings.setAllHeaderTextColor(headerTextColor: UIColor.white)
        self.basReport.layoutSettings.setAllHeaderBackgroundColor(headerBGColor: excelGreenColor)
        self.basReport.layoutSettings.SECONDARYREPORTDATA_SEPERATORCOLOR = excelGreenColor
        self.basReport.layoutSettings.SECONDARYREPORTDATA_SEPERATORCOLOR_VERTICLE = excelGreenColor
        self.basReport.layoutSettings.setAllDataImageSize(imageSize: CGSize(width: 40.0, height: 40.0))
        self.basReport.layoutSettings.PRIMARYREPORTDATA_TEXTCOLOR = UIColor.white
        
        
        setData()
        
    }
    
    func setData() {
        if let path = Bundle.main.path(forResource: "Example2", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tempData  = try JSONDecoder().decode(RootClockClass.self, from: data )
                //Set imageName in Array
                let objectdata =  tempData.data?.map({ (reportData) -> clockData in
                    var temp = reportData
                    temp.imageFor12Oclock = "clockImage"
                    temp.isCheck = false
                    return temp
                })
                //Store Data in Global Array
                self.sampleData = objectdata!
                
                
                /*Send Dictionary keys to BASReport
                 1) Key received from JSON
                 2) Allignment of Text
                 3) Custom size for cell
                 4) Color of Cell or Text
                 */
                
                self.basReport.arrGKeys = [("Day",.center,nil , excelGreenColor) , ("H1_00mm",.center,cellWidth , nil) , ("H2_00mm",.center,cellWidth , nil) , ("H3_00mm",.center,200.0 , nil) , ("H4_00mm",.center,cellWidth , nil) , ("H5_00mm",.center,cellWidth , nil) , ("H6_00mm",.center,nil , nil)  , ("H7_00mm",.center,nil , nil) ,  ("H8_00mm",.center,cellWidth , nil) ,  ("H9_00mm",.center,cellWidth , nil) ,  ("H10_00mm",.center,cellWidth , nil) ,  ("H11_00mm",.center,cellWidth , nil)  , ("imageFor12Oclock",.center,nil , nil) ]
                //Send your Data to BASReport in Dictionary form
                if basReport.arrGHeader.count == basReport.arrGKeys.count{
                    self.basReport.arrReportSummaryDict = arryToDict(array: self.sampleData)
                }
            } catch {
                // handle error
            }
        }
    }
    
}

/* Here you can set your custom Header as par your requirement.
 For ex:- Here i need to display custom header in 3rd column. So, I have passed
 basReport.basReportHeaderDatasource = self
 basReport.arrCustomHeaderSectionForColumn = [3] **Column starts from 0**
 in ViewDidLoad Method. so, If BASReport need to set customHeader for 3rd column then it will pickup customCell from Here.
 Array(basReport.arrGHeader.keys)[column]
 buy above line you will get your title from arrGHeader. Ex:- if column[0] then you will get number of Days
 */
extension BASReportWithCustomCell: BASReportHeaderDatasource {
    func basReport(_ tableView: UITableView, viewForHeaderInSection section: Int, column: Int) -> UIView? {
        if column == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tblCellWithImage") as! tblCellWithImage
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.lblLocation.centerYAnchor.constraint(equalTo: cell.img1.centerYAnchor).isActive = true
            cell.img1.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            cell.img1.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
            cell.contentView.backgroundColor = excelGreenColor
            cell.vwDown.backgroundColor = excelGreenColor
            cell.vwSide.backgroundColor = excelGreenColor
            cell.lblLocation.textColor = UIColor.white
            cell.btnCheckUncheck.isHidden = false
            cell.lblDetailDescription.text = ""
            //Here you will display your Header Text
            cell.lblLocation.text = Array(basReport.arrGHeader.keys)[column]
            cell.img1.image = isAllChecked ? UIImage(named: "header_check")  : UIImage(named: "header_uncheck")
            cell.btnCheckUncheck.addTarget(self, action: #selector(btnCheckUnCheckTapped(_:)), for: .touchUpInside)
            
            return cell.contentView
        }
        return nil
    }
    
    @IBAction func btnCheckUnCheckTapped(_ sender: UIButton) {
        self.isAllChecked.toggle()
        basReport.reloadColumn(columnNo: 3)
        
    }
    
    
}

/* Here you can set your custom Cell as par your requirement.
 For ex:- Here i need to display custom cell in 1st column and 3rd column. So, I have passed
 basReport.basReportHeaderDatasource = self
 basReport.arrCustomIndexPathForColumn = [0,3] //Simple array of Int in which you need to pass column Index
 in ViewDidLoad Method. so, If BASReport need to set customRow for 1st and 3rd column then it will pickup customCell from Here
 
 Here to display Text you need To pass Key for Dictionary.
 Ex:-               basReport.arrReportSummaryDict[indexPath.row][basReport.arrGKeys[column].0] as? String
 Description:- basReport.arrReportSummaryDict[indexPath.row] // This is Array of Dictionary and it will Select Particular Dictionary with [indexPath.row]
 [basReport.arrGKeys[column].0] as? String //arrGkeys is arry of keys(touple and 0 is for key) for Our dictionary.
 so, the combination is :-  basReport.arrReportSummaryDict[indexPath.row][basReport.arrGKeys[column].0] as? String
 
 */
extension BASReportWithCustomCell : BASReportDatasource {
    func basReport(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, column: Int) -> UITableViewCell {
        //Here is also you can use multiple customCell as par you Column or also as par indexPath row
        if column == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tblCellWithImage", for: indexPath) as! tblCellWithImage
            cell.makeRounded()
            cell.vwDown.backgroundColor = excelGreenColor
            cell.vwSide.backgroundColor = excelGreenColor
            cell.lblLocation.text = basReport.arrReportSummaryDict[indexPath.row][basReport.arrGKeys[column].0] as? String
            cell.lblDetailDescription.text = "Surat"
            cell.img2.image = indexPath.row % 2 == 0 ? UIImage(named: "online") : UIImage(named: "offline")
            
            return cell
        } else if column == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tblCellWithImage", for: indexPath) as! tblCellWithImage
            cell.img1.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
            cell.img1.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
            cell.vwDown.backgroundColor = excelGreenColor
            cell.vwSide.backgroundColor = excelGreenColor
            cell.img1.image = isAllChecked ? UIImage(named: "check")  : UIImage(named: "uncheck")
            if !isAllChecked {
                if sampleData[indexPath.row].isCheck! {
                    cell.img1.image = UIImage(named: "check")
                }
            }
            cell.lblLocation.text = basReport.arrReportSummaryDict[indexPath.row][basReport.arrGKeys[column].0] as? String
            cell.lblDetailDescription.text = "Surat"
            cell.img2.image = indexPath.row % 2 == 0 ? UIImage(named: "offline") : UIImage(named: "online")
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    
}

/*
 This is the delegate method when UserSelect Particular Row from Cell
 Here you can do validation with Which column is selected with TableHint. => TableHint is your Particular Header
 */
extension BASReportWithCustomCell : BASReportDelegate {
    func didSelectCellAt(indexPath: IndexPath, tableHint: String, basReport: BASCustomReport?) {
        if tableHint == Array(basReport!.arrGHeader.keys)[3] {
            sampleData[indexPath.row].isCheck?.toggle()
            basReport?.reloadRowsForColumn(rows: [indexPath], rowAnimation: .automatic, columnNo: 3)
        } else {
            let  viewController = storyboard!.get(GetSelectionVC.self)!
            viewController.initWith(selectedHeader: tableHint, selectedText: self.sampleData[indexPath.row].Day!, selectedRow: "\(indexPath.row)")
            //Here you can pass your whole array and take the value whatever is useful for you. I took day from my model
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

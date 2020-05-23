//
//  BASReportWithImage.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import BASReport

class BASReportWithImage: UIViewController {
    let  excelGreenColor = UIColor( red: CGFloat(41/255.0), green: CGFloat(88/255.0), blue: CGFloat(24/255.0), alpha: CGFloat(1.0) )
    let cellWidth:CGFloat = 150.0
    
    //Outlets
    @IBOutlet weak var basReport: BASCustomReport!
    //Variables
    var sampleData = [clockData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BASReport with DisplayImage"
        self.basReport.delegate = self
        initialSetup()
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
                
                self.basReport.arrGKeys = [("Day",.center,nil , excelGreenColor) , ("H1_00mm",.center,cellWidth , nil) , ("H2_00mm",.center,cellWidth , nil) , ("H3_00mm",.center,cellWidth , nil) , ("H4_00mm",.center,cellWidth , nil) , ("H5_00mm",.center,cellWidth , nil) , ("H6_00mm",.center,nil , nil)  , ("H7_00mm",.center,nil , nil) ,  ("H8_00mm",.center,cellWidth , nil) ,  ("H9_00mm",.center,cellWidth , nil) ,  ("H10_00mm",.center,cellWidth , nil) ,  ("H11_00mm",.center,cellWidth , nil)  , ("imageFor12Oclock",.center,nil , nil) ]
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

extension BASReportWithImage : BASReportDelegate {
    
    func didSelectCellAt(indexPath: IndexPath, tableHint: String, basReport: BASCustomReport?) {
       let  viewController = storyboard!.get(GetSelectionVC.self)!
        viewController.initWith(selectedHeader: tableHint, selectedText: self.sampleData[indexPath.row].Day!, selectedRow: "\(indexPath.row)")
        //Here you can pass your whole array and take the value whatever is useful for you. I took day from my model
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}


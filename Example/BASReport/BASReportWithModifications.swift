//
//  BASReportWithModifications.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import BASReport

class BASReportWithModifications: UIViewController {
    let  excelGreenColor = UIColor( red: CGFloat(41/255.0), green: CGFloat(88/255.0), blue: CGFloat(24/255.0), alpha: CGFloat(1.0) )
    //Outlets
    @IBOutlet weak var basReport: BASCustomReport!
    //Variables
    var sampleData = [SampleData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BASReport with Normal Modifications"
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
        HeaderDict["Object"] = false ;  HeaderDict["Distance"] = false ;HeaderDict["Running"] = false ;HeaderDict["Idle"] = false ;HeaderDict["Max Temperature"] = false; HeaderDict["Min Temperature"] = false;HeaderDict["No Of Times Above Ideal"] = false
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
        self.basReport.layoutSettings.PRIMARYREPORTDATA_TEXTCOLOR = UIColor.white
        
       
        setData()
    }
    
    func setData() {
        if let path = Bundle.main.path(forResource: "Example", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let tempData  = try JSONDecoder().decode(RootClass.self, from: data )
                self.sampleData = tempData.data!
                
                
                /*Send Dictionary keys to BASReport
                 1) Key received from JSON
                 2) Allignment of Text
                 3) Custom size for cell
                 4) Color of Cell or Text
                 */
                
                self.basReport.arrGKeys = [("object",.left,nil , excelGreenColor) , ("distance",.center,100.0 , nil) , ("running",.center,nil , nil) , ("idle",.center,80.0 , nil) , ("max_temperature",.center,nil , nil) , ("min_temperature",.center,nil , nil) , ("no_below_ideal",.center,nil , nil) ]
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

extension BASReportWithModifications : BASReportDelegate {
    func selectedSorting(sender:UIButton , BASReportView:BASCustomReport , sorting:ComparisonResult) {
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[0]  {
            self.sampleData = self.sampleData.sorted(by: {$0.object!.localizedCaseInsensitiveCompare($1.object!) == sorting  })
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[1]  {
            if sorting.rawValue == -1 {
                self.sampleData =  self.sampleData.sorted(by: { $0.distance! < $1.distance! })
            } else {
                self.sampleData =  self.sampleData.sorted(by: { $0.distance! > $1.distance! })
            }
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[2]  {
            self.sampleData = self.sampleData.sorted(by: {$0.running!.localizedCaseInsensitiveCompare($1.running!) == sorting  })
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[3]  {
            self.sampleData = self.sampleData.sorted(by: {$0.idle!.localizedCaseInsensitiveCompare($1.idle!) == sorting  })
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[4]  {
            if sorting.rawValue == -1 {
                self.sampleData =  self.sampleData.sorted(by: { $0.max_temperature! < $1.max_temperature! })
            } else {
                self.sampleData =  self.sampleData.sorted(by: { $0.max_temperature! > $1.max_temperature! })
            }
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[5]  {
            if sorting.rawValue == -1 {
                self.sampleData =  self.sampleData.sorted(by: { $0.min_temperature! < $1.min_temperature! })
            } else {
                self.sampleData =  self.sampleData.sorted(by: { $0.min_temperature! > $1.min_temperature! })
            }
        }
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[6]  {
            if sorting.rawValue == -1 {
                self.sampleData =  self.sampleData.sorted(by: { $0.no_below_ideal! < $1.no_below_ideal! })
            } else {
                self.sampleData =  self.sampleData.sorted(by: { $0.no_below_ideal! > $1.no_below_ideal! })
            }
        }
        
        self.basReport.arrReportSummaryDict = arryToDict(array:self.sampleData )
        
    }
}

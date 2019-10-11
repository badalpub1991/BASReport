//
//  ViewController.swift
//  BASReport
//
//  Created by badalpub1991@gmail.com on 10/10/2019.
//  Copyright (c) 2019 badalpub1991@gmail.com. All rights reserved.
//

import UIKit
import BASReport

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var basReport: BASCustomReport!
    
    //Variables
    var sampleData = [SampleData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BASReport Example"
        self.basReport.delegate = self
        initialSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initialSetup() {
        /* Set Header as! OrderedDictionary
         1) Object , Distance , Running etc set as Header
         2) Boolian value -> true if you want to set image , false if not set image
         and then pass it to BASReport
        */
        
        var HeaderDict = OrderedDictionary<String, Bool>()
        HeaderDict["Object"] = false ;  HeaderDict["Distance"] = false ;HeaderDict["Running"] = false ;HeaderDict["Idle"] = false ;HeaderDict["Max Temperature"] = false; HeaderDict["Min Temperature"] = false;HeaderDict["No Of Times Above Ideal"] = false;HeaderDict["Map"] = true
        self.basReport.arrGHeader = HeaderDict
        //*--------------------------------------------------------*//
        /* Set Layout as Layout class if you want to change layOut -> seperator color , seperator height , header text color , header height , font etc
         1) HeaderFont is for HeaderFont
         2) DataFont is for subCellFont
         */
        self.basReport.layoutSettings.setAllHeaderFont(font: UIFont(name: "Times New Roman", size: 17.0)!)
        self.basReport.layoutSettings.setAllDataFont(font: UIFont(name: "Times New Roman", size: 14.0)!)
        //*--------------------------------------------------------*//
        /* Make first column clickable
         1) if you want to set first column clickable then need to pass "isClikable" flag as true. By default it is false
         2) Change first column color as clickable color
         */
        self.basReport.isClikable = true
        self.basReport.layoutSettings.isClikableColor = UIColor.blue

      setData()
    }
    
    func setData() {
        if let path = Bundle.main.path(forResource: "Example", ofType: "json") {
         do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let tempData  = try JSONDecoder().decode(RootClass.self, from: data )
                 //Set imageName in Array
                 let objectdata =  tempData.data?.map({ (reportData) -> SampleData in
                                       var temp = reportData
                                    temp.imageName = "mapicon"
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
            self.basReport.arrGKeys = [("object",.left,nil , nil) , ("distance",.center,100.0 , nil) , ("running",.center,nil , nil) , ("idle",.center,80.0 , nil) , ("max_temperature",.center,nil , nil) , ("min_temperature",.center,nil , nil) , ("no_below_ideal",.center,nil , nil) , ("imageName",.center,nil , nil) ]
            //Send your Data to BASReport in Dictionary form
                       self.basReport.arrReportSummaryDict = arryToDict(array: self.sampleData)
              } catch {
                   // handle error
              }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : BASReportDeleate {
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
        if sender.accessibilityHint ==  Array(BASReportView.arrGHeader.keys)[7]  {
                       if sorting.rawValue == -1 {
                           self.sampleData =  self.sampleData.sorted(by: { $0.imageName! < $1.imageName! })
                       } else {
                           self.sampleData =  self.sampleData.sorted(by: { $0.imageName! > $1.imageName! })
                       }
             }
        self.basReport.arrReportSummaryDict = arryToDict(array:self.sampleData )

    }
}


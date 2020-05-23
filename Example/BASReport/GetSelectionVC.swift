//
//  GetSelectionVC.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class GetSelectionVC: UIViewController {
    
    @IBOutlet weak var lblSelection: UILabel!
    fileprivate var displayText:NSMutableAttributedString?
    
    func  initWith(selectedHeader:String , selectedText:String , selectedRow:String) {
        let font = UIFont.systemFont(ofSize: 22)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.red,
        ]
        
        displayText = NSMutableAttributedString.init(string: "Your selected Header is ")
        displayText?.append(NSAttributedString.init(string: "\(selectedHeader) \n \n", attributes: attributes))
        let text2 = NSMutableAttributedString.init(string: "selected anyValue from Array ")
        text2.append(NSAttributedString.init(string: "\(selectedText) \n \n", attributes: attributes))
        let text3 = NSMutableAttributedString.init(string: "your selected Row is ")
        text3.append(NSAttributedString.init(string: "\(selectedRow) \n \n", attributes: attributes))
        displayText?.append(text2)
        displayText?.append(text3)
        
    }
    override func viewDidLoad() {
         self.title = "Fetched data From BASReport"
        lblSelection.attributedText = displayText
        
    }
    
}

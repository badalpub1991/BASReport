//
//  tblCellWithImage.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class tblCellWithImage: UITableViewCell {
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDetailDescription: UILabel!
    
    @IBOutlet weak var vwDown: UIView!
    @IBOutlet weak var vwSide: UIView!
    @IBOutlet weak var btnCheckUncheck: UIButton!
    
    
    func makeRounded() {
        img1.layer.cornerRadius = img1.frame.width/2
              img2.layer.cornerRadius = img2.frame.width/2
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

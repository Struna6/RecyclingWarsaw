//
//  EmailCell.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 21/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit

class EmailCell: UITableViewCell{
    var theTextLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       configure()
    }
    
    func configure(){
        backgroundColor = .purple
        theTextLabel = UILabel()
        theTextLabel.textColor = .white
        theTextLabel.lineBreakMode = .byTruncatingMiddle
        theTextLabel.numberOfLines = 3
        theTextLabel.font = UIFont(name: "Futura-Medium", size: 15.0)
        self.contentView.addSubview(theTextLabel)
        theTextLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TrashHintCell.swift
//  RecyclingWarsaw
//
//  Created by Aleksandra on 10/02/2020.
//  Copyright © 2020 DodoCode. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TrashHintCell: UITableViewCell{
    var trashNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       configure()
    }
    
    func configure(){
        trashNameLabel = UILabel()
        trashNameLabel.lineBreakMode = .byWordWrapping
        trashNameLabel.numberOfLines = 2
        self.contentView.addSubview(trashNameLabel)
        trashNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

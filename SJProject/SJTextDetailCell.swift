//
//  SJTextDetailCell.swift
//  SJProject
//
//  Created by 王斌绩 on 2021/4/25.
//

import UIKit

class SJTextDetailCell: UICollectionViewCell {
    
    let width1 = UIScreen.main.bounds.size.width
    var titleLabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initView() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: (width1 / 5), height: 50)
        titleLabel.text = "Hello"
        self.addSubview(titleLabel)
    }
    
}

//
//  PayWallDescriptionView.swift
//  Blog App
//
//  Created by Aurelio Le Clarke on 14.07.2022.
//

import UIKit

class PayWallDescriptionView: UIView {

    private let descriptorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Palatino", size: 26)
        label.text = "Join for Blog to read unlimited articles!"
        label.numberOfLines = 0
        
        return label
        
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .thin)
        label.text = "$4.99 / month "
        label.numberOfLines = 1
        return label
        
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(priceLabel)
        addSubview(descriptorLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLabel.frame = CGRect(x: 20, y: height/2, width: width-40, height: height/2)
        descriptorLabel.frame = CGRect(x: 20, y:0, width: width-40, height: height/2)
    }

}

//
//  PayWallHeaderView.swift
//  
//
//  Created by Aurelio Le Clarke on 11.07.2022.
//

import UIKit

class PayWallHeaderView: UIView {

    private let headerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.tintColor = .white
        imageView.frame = CGRect(x: 0, y: 0, width: 220, height: 220)
        imageView.contentMode = .scaleAspectFit
        return imageView
         
}()

    override init(frame: CGRect) {
        super.init(frame: frame)
    clipsToBounds = true
        addSubview(headerImageView)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.center = center
    }

}


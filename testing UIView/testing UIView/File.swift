//
//  File.swift
//  testing UIView
//
//  Created by Aurelio Le Clarke on 17.07.2022.
//

import Foundation
import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    var height: CGFloat {
        frame.size.height
    }
    var left: CGFloat {
        frame.origin.x
    }
    var right: CGFloat {
       left + width
    }
    var top: CGFloat {
        frame.origin.y
    }
    var bottom: CGFloat {
       top + height
    }
}

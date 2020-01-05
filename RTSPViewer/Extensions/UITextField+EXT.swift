//
//  UITextField+EXT.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

extension UITextField {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true

        shake.fromValue = [self.center.x - 6, self.center.y]
        shake.toValue = [self.center.x + 6, self.center.y]
        self.layer.add(shake, forKey: "position")
    }
}

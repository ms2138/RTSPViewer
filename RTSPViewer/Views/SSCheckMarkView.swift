//
//  SSCheckMarkView.swift
//  CameraViewer
//
//  Created by mani on 2019-09-08.
//  Copyright © 2019 mani. All rights reserved.
//
// https://stackoverflow.com/questions/18977527/how-do-i-display-the-standard-checkmark-on-a-uicollectionviewcell

import UIKit

class SSCheckMarkView: UIView {
    enum SSCheckMarkStyle: UInt {
        case openCircle
        case grayedOut
    }

    var checked: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }

    var checkMarkStyle: SSCheckMarkStyle = .grayedOut {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if checked {
            drawCheckedRect(rect: rect)
        }
    }

    func drawCheckedRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let checkmarkBlue2 = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1)
        let shadow2 = UIColor.black

        let shadow2Offset = CGSize(width: 0.1, height: -0.1)
        let shadow2BlurRadius = 2.5
        let frame = self.bounds
        let group = CGRect(x: frame.minX + 3,
                           y: frame.minY + 3,
                           width: frame.width - 6,
                           height: frame.height - 6)

        let checkedOvalPath = UIBezierPath(ovalIn: CGRect(x: group.minX + floor(group.width * 0.00000 + 0.5),
                                                          y: group.minY + floor(group.height * 0.00000 + 0.5),
                                                          width: floor(group.width * 1.00000 + 0.5) -
                                                                 floor(group.width * 0.00000 + 0.5),
                                                          height: floor(group.height * 1.00000 + 0.5) -
                                                                  floor(group.height * 0.00000 + 0.5)))

        context!.saveGState()
        context!.setShadow(offset: shadow2Offset, blur: CGFloat(shadow2BlurRadius), color: shadow2.cgColor)
        checkmarkBlue2.setFill()
        checkedOvalPath.fill()
        context!.restoreGState()
        UIColor.white.setStroke()
        checkedOvalPath.lineWidth = 1
        checkedOvalPath.stroke()

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: group.minX + 0.27083 * group.width, y: group.minY + 0.54167 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.41667 * group.width, y: group.minY + 0.68750 * group.height))
        bezierPath.addLine(to: CGPoint(x: group.minX + 0.75000 * group.width, y: group.minY + 0.35417 * group.height))
        bezierPath.lineCapStyle = CGLineCap.square
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1.3
        bezierPath.stroke()
    }
}

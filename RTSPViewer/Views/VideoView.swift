//
//  VideoView.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-07.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoView: UIView {
    let textLabel = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {
        textLabel.text = "Loading video..."
        textLabel.font = UIFont.systemFont(ofSize: 18.0)
        textLabel.textColor = .white

        addSubview(textLabel)
    }
}

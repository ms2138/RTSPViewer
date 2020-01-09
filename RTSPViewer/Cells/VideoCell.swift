//
//  VideoCell.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-07.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    var videoView: VideoView

    override init(frame: CGRect) {
        videoView = VideoView(frame: frame)

        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        videoView = VideoView(frame: .zero)

        super.init(coder: coder)

        initialize()
    }

    private func initialize() {
        videoView.aspectRatio = "1:1"

        contentView.addSubview(videoView)
    }
}

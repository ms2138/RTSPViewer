//
//  VideoCell.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-07.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    var videoView = VideoView(frame: .zero)
    var checkMarkView = SSCheckMarkView(frame: .zero)
    override var isSelected: Bool {
        didSet {
            checkMarkView.checked = isSelected
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialize()
    }

    private func initialize() {
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.aspectRatio = "1:1"

        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        checkMarkView.checked = false
        checkMarkView.backgroundColor = .clear

        contentView.addSubview(videoView)
        contentView.addSubview(checkMarkView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            videoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])

        NSLayoutConstraint.activate([
            checkMarkView.heightAnchor.constraint(equalToConstant: 35.0),
            checkMarkView.widthAnchor.constraint(equalToConstant: 35.0),
            checkMarkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            checkMarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }

    func playStream(at url: URL) {
        videoView.loadVideo(from: url)
    }

    func stopStream() {
        videoView.unloadVideo()
    }
}

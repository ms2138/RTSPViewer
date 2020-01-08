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
    let mediaPlayer = VLCMediaPlayer()
    var isMuted: Bool = true {
        willSet {
            mediaPlayer.audio.volume = (newValue == true) ? 0 : 100
        }
    }
    var aspectRatio: String = "16:9" {
        willSet {
            mediaPlayer.videoAspectRatio = UnsafeMutablePointer<Int8>(mutating: (newValue as NSString).utf8String)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {
        mediaPlayer.drawable = self

        textLabel.text = "Loading video..."
        textLabel.font = UIFont.systemFont(ofSize: 18.0)
        textLabel.textColor = .white

        addSubview(textLabel)
    }

    override func layoutSubviews() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
            ])
    }

    func loadVideo(from url: URL) {
        let media = VLCMedia(url: url)
        mediaPlayer.media = media
        isMuted = true
        mediaPlayer.play()
    }
}

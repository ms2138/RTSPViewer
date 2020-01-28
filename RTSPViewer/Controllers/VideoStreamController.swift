//
//  VideoStreamController.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-26.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoStreamController: UIViewController {
    @IBOutlet weak var videoView: VideoView!
    var videoStreamURL: URL? {
        willSet {
            if let url = newValue {
                if let videoView = videoView {
                    videoView.loadVideo(from: url)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
}

extension VideoStreamController {
    // MARK: Device Orientation

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var shouldAutorotate: Bool {
        return true
    }
}

extension VideoStreamController {
// MARK: IBActions

    @IBAction func close(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

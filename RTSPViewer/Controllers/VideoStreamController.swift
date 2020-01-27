//
//  VideoStreamController.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-26.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class VideoStreamController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

//
//  RTSPStreamViewController.swift
//  RTSPViewer
//
//  Created by mani on 2019-12-26.
//  Copyright © 2019 mani. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RTSPStreamCell"

class RTSPStreamViewController: UICollectionViewController {

    private var videoStreams = [URL]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RTSPStreamViewController {
    func add(stream: URL) {
        videoStreams.append(stream)

        videoStreams.sort { $0.absoluteString < $1.absoluteString }

        if let index = self.videoStreams.firstIndex(of: stream) {
            let indexPath = IndexPath(row: index, section: 0)
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension RTSPStreamViewController {
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoStreams.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell

        let videoStreamURL = videoStreams[indexPath.row]
        cell.playStream(at: videoStreamURL)

        return cell
    }
}

extension RTSPStreamViewController {
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addStream":
            addStream(for: segue)
        default:
            preconditionFailure("Segue identifier did not match")
        }
    }

    private func addStream(for segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController else { return }
        guard let topController = navController.topViewController else { return }
        guard let viewController = topController as? AddStreamViewController else { return }

        viewController.handler = { [unowned self] (url) in
            self.add(stream: url)
        }
    }
}

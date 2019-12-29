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

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell

        return cell
    }
}

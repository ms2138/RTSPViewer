//
//  UICollectionView+EXT.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-25.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        indexPathsForSelectedItems?.forEach { deselectItem(at: $0, animated: true) }
    }
}


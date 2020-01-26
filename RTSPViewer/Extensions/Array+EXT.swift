//
//  Array+EXT.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-25.
//  Copyright © 2020 mani. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }

    mutating func removeElements(in collection: [Element]) {
        collection.forEach { remove(element: $0) }
    }
}

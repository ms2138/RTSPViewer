//
//  String+EXT.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

extension String: Evaluatable {
    func evaluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else {
            return false
        }

        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
}

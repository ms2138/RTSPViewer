//
//  Evaluatable.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 mani. All rights reserved.
//

import Foundation

protocol Evaluatable {
    associatedtype Expression

    func evaluate(with condition: Expression) -> Bool
}

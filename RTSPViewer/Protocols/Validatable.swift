//
//  Validatable.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

protocol Validatable {
    associatedtype Validators

    func validate(_ functions: [Validators]) -> Bool
}

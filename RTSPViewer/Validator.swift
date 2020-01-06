//
//  Validator.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

class Validator {
    func isURLValid(text: String) -> Bool {
        let regexp = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$"
        return text.evaluate(with: regexp)
    }
}

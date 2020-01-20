//
//  Validator.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 mani. All rights reserved.
//

import Foundation

class Validator {
    func isURLValid(text: String) -> Bool {
        let regexp = "(?i)(http?|https|rtsp)://(?:www\\.)?\\S+(?:/|\\b)"
        return text.evaluate(with: regexp)
    }
}

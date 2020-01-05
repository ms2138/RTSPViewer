//
//  TextInputCell.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-05.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class TextInputCell: UITableViewCell {
    let textField: UITextField

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = UITextField()

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        textField = UITextField()

        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(textField)
    }
}

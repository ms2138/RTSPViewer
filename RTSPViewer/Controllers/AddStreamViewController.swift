//
//  AddStreamViewController.swift
//  RTSPViewer
//
//  Created by mani on 2020-01-01.
//  Copyright © 2020 mani. All rights reserved.
//

import UIKit

class AddStreamViewController: UITableViewController {
    @IBOutlet weak var urlCell: TextInputCell!
    var handler: ((URL) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Stream"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension AddStreamViewController {
    // MARK: - Text field validation

    func handleTextfieldValidation(in textField: UITextField, message: String) {
        textField.text = ""
        let placeholderTextColor = UIColor(red: 236.0/255.0, green: 75.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        textField.attributedPlaceholder = NSAttributedString(string: message,
                                                             attributes:
            [NSAttributedString.Key.foregroundColor: placeholderTextColor])
        textField.textColor = .red
        textField.shake()

        textField.becomeFirstResponder()
    }
}


extension AddStreamViewController {
    // MARK: - IBAction

    @IBAction func done() {
        let textField = urlCell.textField
        let validator = Validator()

        if textField.validate([validator.isURLValid]) == false {
            handleTextfieldValidation(in: textField,
                                      message: "Please enter a valid URL")
        }

        if let url = textField.text {
            if let url = URL(string: url) {
                handler?(url)
            }
        }
    }
}


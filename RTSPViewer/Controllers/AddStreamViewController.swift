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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupTextInputCell()

        urlCell.textField.becomeFirstResponder()
    }
}

extension AddStreamViewController {
    // MARK: - Setup

    private func setupTextInputCell() {
        let textField = urlCell.textField

        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.autocapitalizationType = .none
        textField.keyboardType = .URL
        textField.returnKeyType = .done
    }
}

extension AddStreamViewController {
    // MARK: - Text field validation and changes

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

    @objc func textDidChange(sender: UITextField) {
        if sender.textColor != .black {
            sender.textColor = .black
        }
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
                dismiss(animated: true) { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.handler?(url)
                }
            }
        }
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddStreamViewController: UITextFieldDelegate {
    // MARK: - Text field delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
            done()
            return true
        }
        return false
    }
}

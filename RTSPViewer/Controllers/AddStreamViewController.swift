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

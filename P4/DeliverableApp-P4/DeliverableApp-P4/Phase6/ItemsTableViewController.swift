//
//  ItemsTableViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 14.09.2026..
//

import UIKit

class ItemsTableViewController: UITableViewController {
    let items = SymbolItem.library

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "P6 - D1 - Table - Table view"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
//        cell.textLabel?.text = item.label
//        cell.imageView?.image = UIImage(systemName: item.symbolName)
        var content = UIListContentConfiguration.subtitleCell()
        content.text = item.label
        content.secondaryText = item.description
        content.image = UIImage(systemName: item.symbolName)
        return cell
    }
}

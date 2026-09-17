//
//  ItemsTableViewController.swift
//  DeliverableApp-P4
//
//  Created by Damir Stojanov on 14.09.2026..
//

import UIKit

// TODO: How to make sure the list is alphabetical in order?

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

        /// Prefererable to use Configuration API for Accessibility to modify cell content
        /// instead of legacy alternative above.
        var content = UIListContentConfiguration.subtitleCell()
        content.text = item.label
        content.textProperties.font = .preferredFont(forTextStyle: .body)
        content.secondaryText = item.description
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
        content.image = UIImage(systemName: item.symbolName)
        content.imageProperties.maximumSize = CGSize(width: 30, height: 30)

        cell.contentConfiguration = content
        return cell
    }
}

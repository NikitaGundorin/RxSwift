//
//  TableViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 18.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import Bond

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var removeButton: UIButton!
    
    let names = ["Artyom", "Svetlana", "Philip", "Ilya", "Evgeny", "Polina", "Aleksandr", "Ivan", "Nikita", "Dmitry", "Nataliya", "Anna", "Anastasiya", "Stepan", "Nilolay", "Andrey", "Elena", "Daria"]
    
    let namesDataSouce = MutableObservableArray(["Nikita", "Andery", "Ivan", "Andrey"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        namesDataSouce.bind(to: tableView) { (dataSouce, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            cell.nameLabel.text = dataSouce[indexPath.row]
            return cell
        }
        
        namesDataSouce.map { $0.collection.count < 1 }
            .bind(to: removeButton.reactive.isHidden)
    }
    
    @IBAction func add(_ sender: Any) {
        let name = names[Int.random(in: 0..<names.count)]
        namesDataSouce.insert(name, at: 0)
    }
    
    @IBAction func remove(_ sender: Any) {
        namesDataSouce.removeLast()
    }
}

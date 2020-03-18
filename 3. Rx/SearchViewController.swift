//
//  SearchViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 18.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import Bond

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.reactive.text
            .ignoreNils()
            .filter { $0.count > 0 }
            .debounce(for: 0.5)
            .observeNext { text in print("Отправка запроса для \(text)") }
    }

}

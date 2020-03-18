//
//  CounterViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 18.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import Bond

class CounterViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    var counter = Observable(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        counter.map { "\($0)" }
            .bind(to: counterLabel.reactive.text)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func increase(_ sender: Any) {
        counter.value += 1
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

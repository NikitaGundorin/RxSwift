//
//  RocketViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 18.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit
import Bond

class RocketViewController: UIViewController {
    
    var didLeftPress = Observable(false)
    var didRightPress = Observable(false)

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func leftPressed(_ sender: Any) {
        didLeftPress.value = true
    }
    
    @IBAction func rightPressed(_ sender: Any) {
        didRightPress.value = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didRightPress.combineLatest(with: didLeftPress)
            .map { $0 && $1 ? "Ракета запущена" : "" }
        .bind(to: statusLabel)
        
        didRightPress.map { $0 ? UIColor.systemRed : UIColor.systemBlue}
            .bind(to: rightButton.reactive.tintColor)
        
        didLeftPress.map { $0 ? UIColor.systemRed : UIColor.systemBlue}
            .bind(to: leftButton.reactive.tintColor)
    }
}

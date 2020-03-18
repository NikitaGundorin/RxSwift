//
//  MemoryLeaksViewController.swift
//  3. Rx
//
//  Created by Никита Гундорин on 18.03.2020.
//  Copyright © 2020 Никита Гундорин. All rights reserved.
//

import UIKit

class MemoryLeaksViewController: UIViewController {
    
    var someFunc: (() -> Void)?

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstView = FirstView(view: nil)
        let secondView = SecondView(view: firstView)
        let thirdView = ThirdView(view: secondView)
        
        firstView.customView = thirdView
        //Объекты по кругу ссылаются друг на друга
        
        
        someFunc = self.createMemoryLeak
        //Контроллер ссылается сам на себя
        
        button.reactive.tap.observeNext { self.createMemoryLeak() }
        //Также создается замыкание на самого себя
    }
    
    func createMemoryLeak() {
        print("Memory Leak")
    }
    
    deinit {
        print("MemoryLeaksViewController---")
    }
}

class FirstView {
    var customView: ThirdView?
    
    init(view: ThirdView?) {
        customView = view
        print("FirstView +++")
    }
    
    deinit {
        print("FirstView ---")
    }
}

class SecondView {
    let customView: FirstView
   
    init(view: FirstView) {
        customView = view
        print("SecondView +++")
    }
    
    deinit {
        print("SecondView ---")
    }
}

class ThirdView {
     let customView: SecondView
    
     init(view: SecondView) {
         customView = view
         print("ThirdView +++")
     }
     
     deinit {
         print("ThirdView ---")
     }
}

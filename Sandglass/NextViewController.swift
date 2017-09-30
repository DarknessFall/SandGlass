//
//  NextViewController.swift
//  Sandglass
//
//  Created by Bruce Jackson on 2017/9/30.
//  Copyright © 2017年 zysios. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    var sandglass: Sandglass?
    var total = 100

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sandglass = Sandglass.scheduleOneshot(interval: 1) { [weak self] in
            self?.total -= 1
        }
    }

}

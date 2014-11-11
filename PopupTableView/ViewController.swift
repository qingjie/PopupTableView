//
//  ViewController.swift
//  PopupTableView
//
//  Created by zztx on 14-11-11.
//  Copyright (c) 2014年 指掌天下. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func show(sender: AnyObject) {
        PopupTableView.popupTableView(["1","234","23r4","1","234","23r4","1","234","23r4"], didSelectRowAtIndexPath: { (indexPath) -> () in
            
        }).show()
        
        
    }

}


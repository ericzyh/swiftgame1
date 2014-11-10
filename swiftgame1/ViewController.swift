//
//  ViewController.swift
//  swiftgame1
//
//  Created by 赵宇豪 on 14/11/9.
//  Copyright (c) 2014年 zhaoyuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad() 
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func start(sender: AnyObject) {
        let game = GameViewController()
        self.presentViewController(game, animated: true, completion: {
            print("start game !")
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


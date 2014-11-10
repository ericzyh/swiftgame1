//
//  MyGameViewController.swift
//  swift-2048
//
//  Created by 赵宇豪 on 14/11/7.
//  Copyright (c) 2014年 Austin Zheng. All rights reserved.
//

import UIKit

class GameViewController: UINavigationController , GameModelProtocol {
    
    
    var dimension:Int = 0
    var model:GameModel?
    var blockview:BlockBoardView?
    var label:UILabel
    var arc:Archive
    var level = 1
    
    @IBAction func restart(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var clevel = 0;
        (clevel,_) = arc.read()
        level =  clevel == 0  ? 1:clevel
        dimension = level + 1
        var screenwidth = UIScreen.mainScreen().bounds.width  - 40
        label = UILabel(frame:CGRectMake(screenwidth/2 - 80 , 80, 200, 50))
        model = GameModel(dimension: dimension, delegate: self)
        blockview =  BlockBoardView(dimension: dimension, delegate:self)
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(blockview!)
        view.addSubview(label)
        label.textAlignment = NSTextAlignment.Center
        label.text = "步数 : 0"
        
        var rightItem = UIBarButtonItem(title: "重新开始", style: UIBarButtonItemStyle.Bordered, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = rightItem;
        
        self.navigationItem.prompt = "第"+String(level)+"关"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init() {
        
        label = UILabel(frame:CGRectMake(50, 80, 200, 50))
        arc = Archive()
        super.init(nibName:nil,bundle:nil)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func stepadd(score:Int){
        label.text = "步数 : "+String(score)
    }
    func syndata(p:(Int,Int),val:Int){
        blockview!.change(p,val:val)
    }
    func update(dimension:Int){
        blockview?.createBoard(dimension, delegate:self)
    }
    func win(dimension:Int,step:Int){
        arc.save(level++,step:step)
        self.title = "第"+String(level)+"关"
        blockview?.createBoard(dimension, delegate:self)
    }
    func click(p:(Int,Int)){
        model?.click(p)
    }
     
    
}

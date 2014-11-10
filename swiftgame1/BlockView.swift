//
//  Block.swift
//  swift-2048
//
//  Created by 赵宇豪 on 14/11/7.
//  Copyright (c) 2014年 Austin Zheng. All rights reserved.
//

import UIKit

class BlockView: UIView {
    
    var value:Int = -1
    var position = (0,0)
    var delegate:GameModelProtocol?
    var width:CGFloat
    
    init(width: CGFloat,  delegate:GameModelProtocol) {
        self.width = width
        self.delegate = delegate
        super.init(frame: CGRectMake(0,0, width, width))
        var gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        self.addGestureRecognizer(gesture);
        userInteractionEnabled = true;
        backgroundColor = UIColor.redColor()
    }
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func setPosition(p:(Int,Int)){
        position = p
        var x=0,y=0
        (x,y) = position
        self.frame = CGRectMake(CGFloat(x)*(1+width), CGFloat(y)*(1+width), width, width)
    }
    
    func setValue(value:Int){
        self.value = value
        if(value == 1){
            backgroundColor = UIColor.blueColor()
        }else{
            backgroundColor = UIColor.redColor()
        }
    }
    @objc(tap:)
    func tap(r: UIGestureRecognizer!) {
        delegate!.click(position)
    }
}

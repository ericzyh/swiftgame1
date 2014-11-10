//
//  BlockBoardView.swift
//  swift-2048
//
//  Created by 赵宇豪 on 14/11/7.
//  Copyright (c) 2014年 Austin Zheng. All rights reserved.
//

import UIKit

class BlockBoardView: UIView {
    
    
    var dimension: Int
    var blocks: Matrix<BlockView>!
    var delegate:GameModelProtocol?
    
    init(dimension d: Int, delegate:GameModelProtocol) {
        assert(d > 0)
        dimension = d
        self.delegate=delegate
        var screenwidth = UIScreen.mainScreen().bounds.width  - 40
        super.init(frame: CGRectMake(20, 150, screenwidth, screenwidth))
        createBoard(dimension,delegate: delegate)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func change(p:(Int,Int),val:Int) {
        blocks[p].setValue(val)
    }
    func createBoard(d: Int,delegate:GameModelProtocol) {
        dimension = d
        if blocks != nil {
            for block in blocks.grid {
                block.removeFromSuperview()
            }
        }
        
        var width = (UIScreen.mainScreen().bounds.width-40)/CGFloat(dimension)
        blocks = Matrix(rows:dimension,fun: {() -> BlockView  in
            return BlockView(width:width-1, delegate:delegate)
        })
        
        for i in 0..<dimension {
            for j in 0..<dimension {
                blocks[i,j].setPosition((i,j))
                addSubview(blocks[i,j])
            }
        }

        
    }
    
}

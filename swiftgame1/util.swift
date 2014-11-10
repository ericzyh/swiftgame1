//
//  util.swift
//  swiftgame1
//
//  Created by 赵宇豪 on 14/11/9.
//  Copyright (c) 2014年 zhaoyuhao. All rights reserved.
//

import Foundation

//存档关卡
class Archive {
    
    var userDefault = NSUserDefaults()
    
    func read(level:Int = 0) -> (Int,Int){
        var clevel = level
        if level == 0 {
            clevel = currentlevel()
        }
        var step = userDefault.integerForKey("level"+String(clevel))
        return (clevel,step)
    }
    
    func save(level:Int , step : Int ){
        var clevel = currentlevel()
        if level > clevel {
            userDefault.setObject( level, forKey: "level")
            userDefault.setObject( step, forKey: "level"+String(level))
        }else{
            var (_,cstep) = read(level:level)
            if cstep > step{
                userDefault.setObject( step, forKey: "level"+String(level))
            }
        }
        
    }
    
    private func currentlevel() -> Int{
        return userDefault.integerForKey("level")
    }
    
    func lists() -> [(Int,Int)]{
        var clevel = currentlevel()
        var list = [(Int,Int)]()
        if clevel>0 {
            for index in 1...clevel {
                list.append(index,userDefault.integerForKey("level"+String(index)))
            }
        }
        return list
    }
    
    func removeall(){
        var clevel = currentlevel()
        if clevel>0 {
            for index in 1...clevel {
                userDefault.removeObjectForKey("level"+String(index))
            }
        }
        userDefault.removeObjectForKey("level")
    }
}
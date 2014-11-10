//
//  TopViewController.swift
//  swiftgame1
//
//  Created by 赵宇豪 on 14/11/9.
//  Copyright (c) 2014年 zhaoyuhao. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, UITableViewDataSource {
    var list:Array<(Int,Int)> = []
    
    var toplist: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置tableView的数据源 
        list = Archive().lists()
        toplist=UITableView(frame:CGRectMake(0, 40, view.frame.width, view.frame.height-40),style:UITableViewStyle.Plain)
        self.toplist.dataSource=self
        toplist.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(toplist)
        
        // Do view setup here.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.list.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var row=indexPath.row as Int
        var (index,step) = list[row]
        cell.textLabel.text="第"+(String)(index)+"关 步数"+(String)(step)
        cell.setHighlighted(false, animated: false)
        return cell;
    }
}
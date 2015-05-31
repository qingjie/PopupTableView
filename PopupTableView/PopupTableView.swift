//
//  PopupTableView.swift
//  PopupTableView
//
//  Created by 陈中培 on 14-11-11.
//  Copyright (c) 2014年 陈中培. All rights reserved.
//

import UIKit
let tableViewRowHeight:CGFloat = 44
let popupTableViewBounds:CGRect = UIScreen.mainScreen().bounds
typealias popupTableViewDidSelectRowAtIndexPath = (indexPath: NSIndexPath) -> ()

class PopupTableView: UIView,UITableViewDataSource,UITableViewDelegate {
    
    private var tableView:UITableView!
    private var  control:UIControl!
    private var didSelectRowAtIndexPath:popupTableViewDidSelectRowAtIndexPath!
    private var items:[String]! {
        didSet {
            updateUI()
        }
    }
    
    
    class func popupTableView(items:[String],didSelectRowAtIndexPath:(indexPath: NSIndexPath) -> ()) -> PopupTableView {
        var pop = PopupTableView()
        pop.didSelectRowAtIndexPath = didSelectRowAtIndexPath
        pop.items = items
        return pop
    }
    
    func show() {
        isShow(true)
    }
    
    
  private  func dismiss() {
        isShow(false)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setup() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = tableViewRowHeight
        addSubview(tableView)
        
        control = UIControl(frame:popupTableViewBounds)
        control.backgroundColor  = UIColor(red: 0.16, green: 0.17, blue: 0.21, alpha: 0.5)
        control.addTarget(self, action: "controlPressed", forControlEvents: .TouchUpInside)
        control.addSubview(self)
    }
    
    private func updateUI() {
        
        var keyWindow = UIApplication.sharedApplication().keyWindow!
        keyWindow.addSubview(control)
        var count : Int = items.count > 8 ? 8 : items.count
        var height = CGFloat(count) * tableViewRowHeight
        
        self.frame = CGRectMake(40, popupTableViewBounds.height/2-height/2, 240, height);
        self.center = CGPointMake(keyWindow.bounds.size.width/2.0, keyWindow.bounds.size.height/2.0)
        
        tableView.frame = self.bounds
    }
    
    private func controlPressed() {
        dismiss()
    }
    
    private func isShow(flag:Bool) {
        
        var scaleMix:CGFloat = flag == true ?  0.1 : 1.0
        var scaleMax:CGFloat = flag == false ?  0.1 : 1.0
        
        self.transform = CGAffineTransformMakeScale(scaleMix, scaleMix)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.transform = CGAffineTransformMakeScale(scaleMax, scaleMax)
            
            }) { (finish:Bool) -> Void in
                
                if (flag == false) {
                    self.tableView.removeFromSuperview()
                    self.removeFromSuperview()
                    self.control.removeFromSuperview()
                }
                
        }
        
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel!.text = items[indexPath.row]
        return cell
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectRowAtIndexPath(indexPath:indexPath)
        dismiss()
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    
}

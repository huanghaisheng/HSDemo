//
//  HSSuspendingView.swift
//  HSDemo
//
//  Created by haisheng huang on 2017/1/18.
//  Copyright © 2017年 haisheng huang. All rights reserved.
//

import UIKit


@available(iOS 8.0, *)
public class HSSuspendingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: 单例
    public static let sharedInstance: HSSuspendingView = {
        
        let singleton = HSSuspendingView(frame: CGRect(x: UIScreen.main.bounds.width - 60.0 - 2.0, y: UIScreen.main.bounds.height / 2.0, width: 60.0, height: 60.0), backgroundColor: .yellow)
        //设置单例的属性和需要添加的其他手势需要在初始化方法中实现，否则会无效
//            HSSuspendingView(frame: CGRect(x: UIScreen.main.bounds.width - 60.0, y: UIScreen.main.bounds.height / 2.0, width: 60.0, height: 60.0))
        //设置
//        singleton.backgroundColor = .yellow
//        singleton.layer.masksToBounds = true
//        singleton.layer.cornerRadius = singleton.frame.width / 2.0
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
//        tapGesture.numberOfTapsRequired = 2
//        singleton.addGestureRecognizer(tapGesture)
        
        return singleton
    }()

    
    var touchPoint: CGPoint = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: convenience init
    convenience init(frame: CGRect, backgroundColor: UIColor) {
    
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = frame.width / 2.0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: view moving configure
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch begin")
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var touch: UITouch? = nil
        
        for touchIdx in touches {
            touch = touchIdx
        }
        
        touchPoint = touch!.location(in: self.superview)
        
        self.limitMoveRange(movePoint: &touchPoint)
        
        UIView.animate(withDuration: 0.1) { 
            self.center = self.touchPoint
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch end")
        
        
        
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) -> Void {
        print("double tap!")
    }
    
    //MARK:获取
    
    //MARK:控制悬浮view的移动范围
    func limitMoveRange(movePoint: inout CGPoint) -> Void {
        
        if movePoint.x < self.frame.width / 2.0 {
            movePoint.x = self.frame.width / 2.0 + 2.0
        }
        
        if movePoint.x > UIScreen.main.bounds.width - self.frame.width / 2.0 {
            movePoint.x = UIScreen.main.bounds.width - self.frame.width / 2.0 - 2.0
        }
        
        if movePoint.y < self.frame.height / 2.0 {
            movePoint.y = self.frame.height / 2.0 + 2.0
        }
        
        if movePoint.y > UIScreen.main.bounds.height - self.frame.height / 2.0 {
            movePoint.y = UIScreen.main.bounds.height - self.frame.height / 2.0 - 2.0
        }
    }
    
    
}

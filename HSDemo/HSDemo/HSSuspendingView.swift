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
        
         self.backgroundColor = .green
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        touchPoint = self.transformToPoint(touches: touches)
        
        self.limitMoveRange(movePoint: &touchPoint)
        
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.center = self.touchPoint
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch end")
        
        touchPoint = self.transformToPoint(touches: touches)
        
        self.stopAtPoint(lastMovePoint: &touchPoint)
        
        self.backgroundColor = .yellow
    }
    
    func handleTapGesture(sender: UITapGestureRecognizer) -> Void {
        print("double tap!")
    }
    
    //MARK:获取触点坐标
    func transformToPoint(touches : Set<UITouch>) -> CGPoint {
        
        var touch: UITouch? = nil
        
        for touchIdx in touches {
            touch = touchIdx
        }

        let point = touch!.location(in: self.superview)
        
        return point
    }
    
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
    
    //MARK:控制悬浮view的停止移动后的停靠点
    func stopAtPoint(lastMovePoint: inout CGPoint) -> Void {
        
        
        let leftDistance = fabs(lastMovePoint.x - self.frame.width / 2.0 - 2.0)
        let rightDistance = fabs(UIScreen.main.bounds.width - self.frame.width / 2.0 - 2.0 - lastMovePoint.x)
        let topDistance = fabs(lastMovePoint.y - self.frame.height / 2.0 - 2.0)
        let bottomDistance = fabs(UIScreen.main.bounds.height - self.frame.height / 2.0 - 2.0 - lastMovePoint.y)
        
        var tag = 1
        var minValue = leftDistance
        
        if minValue > rightDistance {
            minValue = rightDistance
            tag = 2
        }
        
        if minValue > topDistance {
            minValue = topDistance
            tag = 3
        }
        
        if minValue > bottomDistance {
            minValue = bottomDistance
            tag = 4
        }
        
        if tag == 1 {
            lastMovePoint.x = self.frame.width / 2.0 + 2.0
        } else if tag == 2 {
            lastMovePoint.x = UIScreen.main.bounds.width - self.frame.width / 2.0 - 2.0
        } else if tag == 3 {
            lastMovePoint.y = self.frame.height / 2.0 + 2.0
        } else if tag == 4 {
            lastMovePoint.y = UIScreen.main.bounds.height - self.frame.height / 2.0 - 2.0
        }
        
//        if lastMovePoint.x < UIScreen.main.bounds.width / 2.0 {
//            lastMovePoint.x = self.frame.width / 2.0 + 2.0
//        } else {
//            lastMovePoint.x = UIScreen.main.bounds.width - self.frame.width / 2.0 - 2.0
//        }
//        
//        if lastMovePoint.y < UIScreen.main.bounds.height / 2.0 {
//            lastMovePoint.y = self.frame.height / 2.0 + 2.0
//        } else {
//            lastMovePoint.y = UIScreen.main.bounds.height - self.frame.height / 2.0 - 2.0
//        }
        
        self.limitMoveRange(movePoint: &touchPoint)
        
        UIView.animate(withDuration: 0.2) { [unowned self] in
            self.center = self.touchPoint
        }
    }
    
    func distanceBetweenPoints(originPoint: CGPoint, destinationPoint: CGPoint) -> CGFloat {
        
        let deltaX = destinationPoint.x - originPoint.x
        let deltaY = destinationPoint.y - originPoint.y
        
        return sqrt(deltaX * deltaX + deltaY * deltaY)
        
    }
    
}

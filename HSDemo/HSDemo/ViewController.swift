//
//  ViewController.swift
//  HSDemo
//
//  Created by haisheng huang on 2017/1/17.
//  Copyright © 2017年 haisheng huang. All rights reserved.
//

import UIKit
import HSCustomView
import HSSwiftExtensions

class ViewController: UIViewController {

    var progress: HSCustomProgress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "首页"
        
        let progressRect = CGRect(x: 15.0, y: 300.0, width: UIScreen.main.bounds.width - 30.0, height: 8.0)
        progress = HSCustomView.createProgress(at: self.view, frame: progressRect, deepColor: .red, lightColor: .yellow, backgroundColor: UIColor.color(with: "0xf0f0f0"), value: 0.9, isCornerRadius: true, direction: .right, isAnimated: true, duration: 2.0)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            [unowned self] in
            self.progress?.value = 0.5
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            [unowned self] in
            self.progress?.value = 0.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            self.stepBystep()
        }
        
//        let suspendingView = HSSuspendingView(frame: CGRect(x: 100.0, y: 100.0, width: 60.0, height: 60.0), backgroundColor: .yellow)
        UIApplication.shared.keyWindow?.addSubview(HSSuspendingView.sharedInstance)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    func stepBystep() -> Void {
    
        for i in 1...100 {
            self.progress?.value = CGFloat(i) / 100.0
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        let nextViewController = SecondViewController.initViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
}


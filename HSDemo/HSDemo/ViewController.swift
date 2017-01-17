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
        
        let progressRect = CGRect(x: 15.0, y: 300.0, width: UIScreen.main.bounds.width - 30.0, height: 8.0)
        progress = HSCustomView.createProgress(at: self.view, frame: progressRect, deepColor: .red, lightColor: .yellow, backgroundColor: UIColor.color(with: "0xf0f0f0"), value: 0.9, isCornerRadius: true, direction: .right, isAnimated: true, duration: 2.0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            [unowned self] in
            self.progress?.value = 0.3
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        DispatchQueue.global().asyncAfter(deadline: .now() + 15.0) {
            [unowned self] in
            self.progress?.value = 0.9
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

}


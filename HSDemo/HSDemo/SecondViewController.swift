//
//  SecondViewController.swift
//  HSDemo
//
//  Created by haisheng huang on 2017/1/18.
//  Copyright © 2017年 haisheng huang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "第二页"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    class func initViewController() -> SecondViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
}

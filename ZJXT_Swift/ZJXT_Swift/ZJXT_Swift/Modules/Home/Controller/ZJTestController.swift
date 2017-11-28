//
//  ZJTestController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/28.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit

class ZJTestController: SecondViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let slider = CSDualWaySlider(frame: CGRect(x: 30, y: 50, width: kScreenViewWidth - 60, height: 70), minValue: 1, maxValue: 100, blockSpaceValue: 1)
        
        slider.minIndicateView.title = "1K"
        slider.minIndicateView.backIndicateColor = kTabbarBlueColor
        slider.maxIndicateView.backIndicateColor = kTabbarBlueColor
        slider.maxIndicateView.title = "100K"
        slider.progressHeight = 3
        slider.progressRadius = 2.5
        slider.lightColor = kTabbarBlueColor
        slider.darkColor = UIColor.color(hex: "#929292")
        slider.frontScale = 0.5
        slider.frontValue = 30
        slider.showAnimate = false
        
        slider.getMinTitle = { minValue in
            if minValue == 1
            {
                return "1K"
            }
            else
            {
                return "\(Int(minValue))K"
            }
        }
        
        slider.getMaxTitle = { maxValue in
            if maxValue == 1
            {
                return "1K"
            }
            else
            {
                return "\(Int(maxValue))K"
            }

        }
        
        self.view.addSubview(slider)
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

}

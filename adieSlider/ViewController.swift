//
//  ViewController.swift
//  adieSlider
//
//  Created by Olar's Mac on 2/8/19.
//  Copyright © 2019 Adie Olami. All rights reserved.
//

import UIKit
import PureLayout
import ChameleonFramework

class ViewController: UIViewController {

    var adieSlider: AdieSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showSlider(_ sender: Any) {
        // ADD THE SLIDER VIEW
            adieSlider = AdieSliderView(frame: CGRect.zero)
            adieSlider.tag = 200
            adieSlider.sliderView.backgroundColor = UIColor.flatRed()
            adieSlider.titleLabel.text = "Slide Me"
            self.view.addSubview(adieSlider)
            
            adieSlider.onChange = {
                print("HEY I CHANGED")
            }
            // AutoLayout
            adieSlider.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
    }
    
    @IBAction func dismissSlider(_ sender: Any) {
        // REMOVE THE SLIDER VIEW
        if let viewWithTag = self.view.viewWithTag(200) {
            viewWithTag.removeFromSuperview()
        }
    }
    

}


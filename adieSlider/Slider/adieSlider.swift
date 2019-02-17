//
//  adieSlider.swift
//  adieSlider
//
//  Created by Olar's Mac on 2/8/19.
//  Copyright © 2019 Adie Olami. All rights reserved.
//

import UIKit
import PureLayout
import ChameleonFramework

protocol SwipeDelegate: class {
    func swiped(for view: AdieSliderView)
}

class AdieSliderView: UIView {
    
    var shouldSetupConstraints = true
    var startingFrame: CGRect?
    weak var swipeDelegate: SwipeDelegate?
    
    var onChange: (() -> Void)?
    let screenSize = UIScreen.main.bounds
    
    let sliderView: UIView = UIImageView(frame: CGRect.zero)
    let sliderImage: UIImageView = UIImageView(frame: CGRect.zero)
    let titleLabel: UILabel = UILabel(frame: CGRect.zero)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        commonInit()
        UIApplication.shared.isStatusBarHidden = true
    }
    
    deinit {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        //        sliderView.backgroundColor = UIColor.flatGreen()
        sliderView.autoSetDimension(.height, toSize: 50)
        
        self.addSubview(sliderView)
        
        sliderImage.backgroundColor = UIColor.clear
        sliderImage.image = UIImage(named: "swiperight.png")
        sliderImage.contentMode = .scaleAspectFit
        
        sliderImage.autoSetDimension(.width, toSize: 50)
        sliderImage.autoSetDimension(.height, toSize: 50)
        
        titleLabel.autoSetDimension(.height, toSize: 50)
        titleLabel.autoSetDimension(.width, toSize: screenSize.width)
        titleLabel.textAlignment = .right
        self.addSubview(titleLabel)
        
        self.addSubview(sliderImage)
        
        swipeFunc()
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            
            //            sliderView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            sliderView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            //            sliderImage.autoPinEdge(toSuperviewEdge: .left)
            sliderImage.autoPinEdge(.top, to: .top, of: sliderView, withOffset: 0.0)
            
            sliderImage.autoPinEdge(.bottom, to: .bottom, of: sliderView, withOffset: 0.0)
            titleLabel.autoPinEdge(.top, to: .top, of: sliderView, withOffset: 0.0)
            titleLabel.autoPinEdge(.bottom, to: .bottom, of: sliderView, withOffset: 0.0)
            
            shouldSetupConstraints = false
        }
        
        super.updateConstraints()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return sliderImage.frame.contains(point)
    }
}

extension AdieSliderView {
    
    private func swipeFunc() {
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(acknowledgeSwiped(sender:)))
        sliderImage.addGestureRecognizer(swipeGesture)
        sliderImage.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func acknowledgeSwiped(sender: UIPanGestureRecognizer) {
        if let sliderView = sender.view {
            let translation = sender.translation(in: self.sliderView) //self.sliderView
            switch sender.state {
            case .began:
                startingFrame = sliderImage.frame
                fallthrough
            case .changed:
                if let startFrame = startingFrame {
                    
                    var movex = translation.x
                    if movex < -startFrame.origin.x {
                        movex = -startFrame.origin.x
                        print("SWIPPERD minmax")
                    }
                    
                    let xMax = self.sliderView.frame.width - startFrame.origin.x - startFrame.width - 15 //self.sliderView
                    if movex > xMax {
                        movex = xMax
                        onChange?()
                    }
                    
                    var movey = translation.y
                    if movey < -startFrame.origin.y { movey = -startFrame.origin.y }
                    
                    let yMax = self.sliderView.frame.height - startFrame.origin.y - startFrame.height //self.sliderView
                    if movey > yMax {
                        movey = yMax
                        //                        print("SWIPPERD min")
                    }
                    
                    sliderView.transform = CGAffineTransform(translationX: movex, y: movey)
                }
            default: // .ended and others:
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
}


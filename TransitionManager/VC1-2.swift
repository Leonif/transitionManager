//
//  ViewController.swift
//  TransitionManager
//
//  Created by Leonid Nifantyev on 9/29/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit

class VC1: UIViewController {
    
    var transitionManager: TransitionManager = TransitionManager()
    
    @IBAction func showTapped() {
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2")
        
        vc2.transitioningDelegate = transitionManager
        
        
//        transitionManager.makeAnimation = { params  in
//            /////// user shoud set ////
//            let offScreenRight = CGAffineTransform(translationX: self.view.frame.width, y: 0)
//            let offScreenLeft = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
//
//            // start the toView to the right of the screen
//            params.toView.transform = params.presenting ? offScreenRight : offScreenLeft
//            // perform the animation!
//            // for this example, just slid both fromView and toView to the left at the same time
//            // meaning fromView is pushed off the screen and toView slides into view
//            // we also use the block animation usingSpringWithDamping for a little bounce
//            UIView.animate(withDuration: params.duration,
//                           delay: 0,
//                           usingSpringWithDamping: 0.5,
//                           initialSpringVelocity: 0.8,
//                           animations: {
//
//                            params.fromView.transform = params.presenting ? offScreenLeft : offScreenRight
//                            params.toView.transform = .identity
//
//            }, completion: { (finished) in
//                // tell our transitionContext object that we've finished animating
//                params.transitionContext.completeTransition(true)
//            })
//        }
        
        
        transitionManager.duration = 0.8
        transitionManager.makeAnimation = { params in
            // set up from 2D transforms that we'll use in the animation

            let offScreenRotateIn = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
            let offScreenRotateOut = CGAffineTransform(rotationAngle: CGFloat.pi/2)

            // set the start location of toView depending if we're presenting or not
            params.toView.transform = params.presenting ? offScreenRotateIn : offScreenRotateOut

            // set the anchor point so that rotations happen from the top-left corner
            params.toView.layer.anchorPoint = CGPoint(x:0, y:0)
            params.fromView.layer.anchorPoint = CGPoint(x:0, y:0)

            // updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
            params.toView.layer.position = CGPoint(x:0, y:0)
            params.fromView.layer.position = CGPoint(x:0, y:0)
            
            UIView.animate(withDuration: params.duration,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.8,
                           animations: {
                            
                            params.fromView.transform = params.presenting ? offScreenRotateOut : offScreenRotateIn
                            params.toView.transform = .identity
                            
            }, completion: { (finished) in
                // tell our transitionContext object that we've finished animating
                params.transitionContext.completeTransition(true)
            })
        }
        
        self.present(vc2, animated: true)
    }
}

class VC2: UIViewController {
    
    @IBAction func hideTapped() {
        self.dismiss(animated: true)
    }
}


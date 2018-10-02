//
//  TransitionManager.swift
//  TransitionManager
//
//  Created by Leonid Nifantyev on 9/29/18.
//  Copyright © 2018 Leonid Nifantyev. All rights reserved.
//

import UIKit


class Params {
    var presenting: Bool
    var duration: TimeInterval
    var transitionContext: UIViewControllerContextTransitioning
    var toView: UIView
    var fromView: UIView
    
    init(presenting: Bool, duration: TimeInterval,
         transitionContext: UIViewControllerContextTransitioning,
         toView: UIView, fromView: UIView) {
        self.presenting = presenting
        self.duration = duration
        self.transitionContext = transitionContext
        self.toView = toView
        self.fromView = fromView
    }
    
}


class TransitionManager: NSObject {
    
    private var presenting: Bool = true
    var makeAnimation: ((Params) -> Void)? = nil
    
    var duration: TimeInterval = 0.5
}


// MARK: UIViewControllerAnimatedTransitioning protocol methods
extension TransitionManager: UIViewControllerAnimatedTransitioning {
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // TODO: Perform the animation
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!

        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        
        let duration = transitionDuration(using: transitionContext)
        
        self.makeAnimation?(Params(presenting: self.presenting,
                                  duration: duration,
                                  transitionContext: transitionContext,
                                  toView: toView,
                                  fromView: fromView))
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
}

// MARK: UIViewControllerTransitioningDelegate protocol methods
extension TransitionManager: UIViewControllerTransitioningDelegate {
    // return the animataor when presenting a viewcontroller
    // remmeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}




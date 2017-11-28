//
//  FadeInTransition.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/19.
//  Copyright © 2017年 runer. All rights reserved.
//
//  淡入淡出专场动画

import UIKit

class FadeInTransition: NSObject,UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {

        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containView = transitionContext.containerView
        
        toView?.frame = (fromView?.frame)!
        toView?.alpha = 0.0
        
        containView.addSubview(toView!)
        
        let dur = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: dur, animations: { 
            toView?.alpha = 1.0
        }) { (finish) in
            
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}

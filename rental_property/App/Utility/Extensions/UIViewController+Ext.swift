//
//  UIViewController+Ext.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/5/23.
//

import UIKit

extension UIViewController{

    func dragView(_ sender: UIPanGestureRecognizer){
        let touchPoint = sender.location(in: view?.window)
        var initialTouchPoint = CGPoint.zero

        switch sender.state {
            case .began:
                initialTouchPoint = touchPoint
            case .changed:
                print(touchPoint.y, initialTouchPoint.y)
                if touchPoint.y > initialTouchPoint.y{
                    view.frame.origin.y = touchPoint.y - initialTouchPoint.y
                }
            case .ended, .cancelled:
                if touchPoint.y - initialTouchPoint.y > 200 {
                    dismiss(animated: true, completion: nil)
                }
                else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.size.width,height: self.view.frame.size.height)
                    })
                }
            case .failed, .possible:
                break
            @unknown default:
                break
            }
    }
}

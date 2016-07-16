//
//  HeartView.swift
//  HeartAnimation
//
//  Created by 卢良潇 on 16/7/16.
//  Copyright © 2016年 卢良潇. All rights reserved.
//

import UIKit

class HeartView: UIView {

    var strokeColor:UIColor?
    var fillColor:UIColor?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        strokeColor = UIColor.white()
        fillColor = ColorManager().getColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)), a: 1)
        backgroundColor = UIColor.clear()
        layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    override func draw(_ rect: CGRect) {
        
      
        strokeColor?.setStroke()
        fillColor?.setFill()
      
        let drawingPadding = 4.0

        let curveRadius = floor((rect.width - CGFloat(2.0 * drawingPadding) ) / 4.0)
        
        let heartPath = UIBezierPath()

        let tipLocation = CGPoint(x: Double(floor(rect.width / 2)), y: Double(rect.height) - drawingPadding)
        
        
        heartPath.move(to: tipLocation)
     
        let topLeftCurveStart = CGPoint(x: drawingPadding, y: Double(rect.height / 2.4))
        
       
        heartPath.addQuadCurve(to: topLeftCurveStart, controlPoint: CGPoint(x: topLeftCurveStart.x, y: topLeftCurveStart.y + curveRadius))
        
       
        //Create top left curve
    heartPath.addArc(withCenter: CGPoint(x: topLeftCurveStart.x + curveRadius,y: topLeftCurveStart.y ), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        //Create top right curve
        
        let topRightCurveStart = CGPoint(x: topLeftCurveStart.x + 2*curveRadius, y: topLeftCurveStart.y);
     
        heartPath.addArc(withCenter: CGPoint(x:topRightCurveStart.x + curveRadius, y: topRightCurveStart.y), radius: curveRadius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        //Final curve to bottom heart tip
        let topRightCurveEnd = CGPoint(x: topLeftCurveStart.x + 4*curveRadius, y: topRightCurveStart.y);

        
        heartPath.addQuadCurve(to: tipLocation, controlPoint: CGPoint(x: topRightCurveEnd.x , y: topRightCurveEnd.y + curveRadius))
        
        heartPath.fill()
        heartPath.lineWidth = 1
        heartPath.lineCapStyle = CGLineCap.round
        heartPath.lineJoinStyle = CGLineJoin.round
        heartPath.stroke()
       
    }
    
    
    func animateInView(view:UIView){
        
        let totalAnimationDuration = 8;
        
        let heartSize = bounds.width
        let heartCenterX = center.x
        let viewHeight = view.bounds.height
        
        
        
        //Pre-Animation setup
        
        transform = CGAffineTransform(scaleX: 0, y: 0)
        alpha = 0

         //Bloom
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            
            self.transform = CGAffineTransform.identity
            self.alpha = 0.9
            }, completion: nil)
       
       
        let i = arc4random_uniform(2)
        
        let rotationDirection = 1 - (2 * Int(i))
        let rotationFraction = arc4random_uniform(10)
        UIView.animate(withDuration: TimeInterval(totalAnimationDuration)) {
           
            self.transform = CGAffineTransform(rotationAngle: CGFloat((Double(rotationDirection) * M_PI) / (Double(16 + rotationFraction) * 0.2)))

        }
        
        let heartTravelPath = UIBezierPath()
        heartTravelPath.move(to: center)
        
        
        
        //random end point
    
        
        let endPoint = CGPoint(x: heartCenterX + CGFloat((rotationDirection) * Int(arc4random_uniform(UInt32(2.0) * UInt32(heartSize)))),y: viewHeight/6.0 + CGFloat(arc4random_uniform(UInt32(viewHeight / 4.0))));
        
        
        
        let j = arc4random_uniform(2)
        let travelDirection = 1 - (2 * Int(j))
        
        //randomize x and y for control points

        
        let xDelta = (heartSize/2.0 + CGFloat(arc4random_uniform((2*UInt32(heartSize)))) * CGFloat(travelDirection))
         let yDelta = max(endPoint.y, max(CGFloat(arc4random_uniform(8 * UInt32(heartSize))),heartSize))

        let controlPoint1 = CGPoint(x: heartCenterX + xDelta ,y: viewHeight - yDelta)
        let controlPoint2 = CGPoint(x: heartCenterX - 2 * xDelta, y: yDelta)
        
        heartTravelPath.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        
        let keyFrameAnimation = CAKeyframeAnimation.init(keyPath: "position")
       
        
        keyFrameAnimation.path = heartTravelPath.cgPath
        keyFrameAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        keyFrameAnimation.duration = TimeInterval(totalAnimationDuration) + TimeInterval( endPoint.y / viewHeight)
        
        layer.add(keyFrameAnimation, forKey: "positionOnPath")

        UIView.animate(withDuration: TimeInterval(totalAnimationDuration), animations: { 
            self.alpha = 0.0
            }) { (finish) in
                self.removeFromSuperview()
        }
        
    }
    
}

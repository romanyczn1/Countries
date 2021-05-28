//
//  PulseButton.swift
//  WebSolutions
//
//  Created by Roman Bukh on 21.05.21.
//

import UIKit

class PulsatingButton: UIButton {
    let pulseLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.clear.cgColor
        shape.lineWidth = 10
        shape.fillColor = UIColor.white.withAlphaComponent(0.25).cgColor
        shape.lineCap = .round
        return shape
    }()
    
    override var bounds: CGRect {
        didSet {
            setupShapes()
        }
    }
    
    fileprivate func setupShapes() {

        backgroundColor = .red
        layer.cornerRadius = 100
        
        let backgroundLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width/2, y: bounds.size.height/2), radius: bounds.size.height/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulseLayer.frame = bounds
        pulseLayer.path = circularPath.cgPath
        self.layer.addSublayer(pulseLayer)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor.blue.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.frame = bounds
        self.layer.addSublayer(backgroundLayer)
                
        let myLayer = CALayer()
        myLayer.frame = bounds
        let onImage = UIImage(named: "on")?.cgImage
        myLayer.contents = onImage
        backgroundLayer.addSublayer(myLayer)
        
        myLayer.contentsGravity = CALayerContentsGravity.center
        myLayer.isGeometryFlipped = true
    }
    
    func pulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.8
        animation.duration = 1.4
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = false
        animation.repeatCount = .infinity
        pulseLayer.add(animation, forKey: "pulsing")
    }
    
    func stopPulse() {
        pulseLayer.removeAllAnimations()
    }
}

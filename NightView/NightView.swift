//
//  NightView.swift
//  Go
//
//  Created by Bobo on 7/8/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import UIKit

class NightView: UIView {
    
    let areaToStarsRatio: CGFloat = 20000.0
    
    let sizeToStarSizeRatio: CGFloat = 100.0
    let starSizeProductRandomizerRange = UInt32(50)...UInt32(150)
    
    let minStarOpacity: Float = 0.5
    
    let starLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(starLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.addSublayer(starLayer)
    }
    
    // MARK: Drawings
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        starLayer.frame = bounds
        drawStars()
    }
    
    private func drawStars() {
        removeSublayersFromLayer(starLayer)
        
        let numberOfStars = numberOfStarsForSize(bounds.size)
        
        for _ in 0...numberOfStars {
            drawStarWithFrame(randomStarFrameInFrame(bounds), boundingFrame: bounds)
        }
    }
    
    private func drawStarWithFrame(frame: CGRect, boundingFrame: CGRect?) {
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.fillColor = UIColor.whiteColor().CGColor
        layer.path = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, frame.width, frame.height)).CGPath
        layer.backgroundColor = UIColor.clearColor().CGColor
        
        if let boundingFrame = boundingFrame {
            layer.opacity = max((Float(boundingFrame.height - frame.origin.y) / 100.0) / (Float(boundingFrame.height) / 100.0), minStarOpacity)
        }
        
        starLayer.addSublayer(layer)
    }
    
    // MARK: Generators
    
    private func randomStarFrameInFrame(frame: CGRect) -> CGRect {
        let size = randomStarSizeInSize(frame.size)
        
        let minX = frame.origin.x
        let maxX = frame.origin.x + frame.size.width
        let minY = frame.origin.y
        let maxY = frame.origin.y + frame.size.height
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        let starFrame = CGRectMake(randomX, randomY, size.width, size.height)
        
        return starFrame
    }
    
    private func randomStarSizeInSize(size: CGSize) -> CGSize {
        let size = min(size.width, size.height)
        let randomStarSizeProduct = CGFloat(arc4random_uniform(starSizeProductRandomizerRange.last! - starSizeProductRandomizerRange.first!) + starSizeProductRandomizerRange.first!) / 100.0;

        return CGSize(width: size / sizeToStarSizeRatio * randomStarSizeProduct, height: size / sizeToStarSizeRatio * randomStarSizeProduct)
    }

    private func intensityForStarAtY(y: Float) -> Float {
        return 1.0
    }
    
    private func numberOfStarsForSize(size: CGSize) -> Int {
        let area = size.width * size.height
        
        return Int(area / areaToStarsRatio)
    }
    
    private func removeSublayersFromLayer(layer: CAShapeLayer) {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
}

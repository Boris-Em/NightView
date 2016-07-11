//
//  NightView.swift
//  Go
//
//  Created by Bobo on 7/8/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import UIKit

@IBDesignable
class NightView: UIView {
    
    /** The number of points for each star. For example, setting this property to 1, means that there will be 1 star for every point in the view. A greater number means less stars within the view.
     Defaults to 10000.0.
     */
    @IBInspectable var numberOfPointsForStar: CGFloat = 10000.0 {
        didSet {
            // REDRAW
        }
    }
    
    /** The size of the stars in points. Defaults to 5.0.
    */
    @IBInspectable var starSize: CGFloat = 5.0 {
        didSet {
            // REDRAW
        }
    }
    
    /** The minimum percent by which the stars' size will be changed. For example, a value of 50.0 means that the minimum size of a star will be 50% of the `starSize` property.
     Defaults to 50.0.
     - SeeAlso: `starSize`
    */
    @IBInspectable var starSizeMinRandomizer = 50.0 {
        didSet {
            starSizeProductRandomizerRange = UInt32(starSizeMinRandomizer)...UInt32(starSizeMaxRandomizer)
        }
    }
    
    /** The maximum percent by which the stars' size will be changed. For example, a value of 150.0 means that the maximum size of a star will be 150% of the `starSize` property.
     Defaults to 50.0.
     - SeeAlso: `starSize`
     */
    @IBInspectable var starSizeMaxRandomizer = 150.0 {
        didSet {
            starSizeProductRandomizerRange = UInt32(starSizeMinRandomizer)...UInt32(starSizeMaxRandomizer)
        }
    }
    
    private var starSizeProductRandomizerRange = UInt32(50)...UInt32(150) {
        didSet {
            // REDRAW
        }
    }
    
    @IBInspectable var minStarOpacity: Float = 0.5 {
        didSet {
            // REDRAW
        }
    }
    
    private let starLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(starLayer)
    }
    
    // MARK: Drawings
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        print("DRAW")
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
        let size = randomStarSizeForSize(starSize)
        
        let minX = frame.origin.x
        let maxX = frame.origin.x + frame.size.width
        let minY = frame.origin.y
        let maxY = frame.origin.y + frame.size.height
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        let starFrame = CGRectMake(randomX, randomY, size.width, size.height)
        
        return starFrame
    }
    
    private func randomStarSizeForSize(starSize: CGFloat) -> CGSize {
        let randomStarSizeProduct = CGFloat(arc4random_uniform(starSizeProductRandomizerRange.last! - starSizeProductRandomizerRange.first!) + starSizeProductRandomizerRange.first!) / 100.0;
        let randomSize = starSize * randomStarSizeProduct

        return CGSize(width: randomSize, height: randomSize)
    }

    private func intensityForStarAtY(y: Float) -> Float {
        return 1.0
    }
    
    private func numberOfStarsForSize(size: CGSize) -> Int {
        let area = size.width * size.height
        
        return Int(area / numberOfPointsForStar)
    }
    
    private func removeSublayersFromLayer(layer: CAShapeLayer) {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}

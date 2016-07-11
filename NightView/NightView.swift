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
    
    /** The color of the stars. Defaults to white.
    */
    @IBInspectable var starColor = UIColor.whiteColor()
    
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
    
    /** The stars are drawn with a smaller opacity at the bottom of the view than at the top. This property sets the minimum opacity for the lower stars. Note that the stars at the top of the view will have an opacity of 1.0 .Defaults to 0.5.
    */
    @IBInspectable var minStarOpacity: Float = 0.5 {
        didSet {
            // REDRAW
        }
    }
    
    /** The intensity of the glowing of the stars, from 0 to 1. If set to 0, the stars will not glow. Defaults to 0.5.
    */
    @IBInspectable var glowingIntensity = 0.5 {
        didSet {
            // REDRAW
        }
    }
    
    /** The duration in seconds at which the stars glow. Defaults to 1.0.
    */
    @IBInspectable var glowingDuration = 0.5 {
        didSet {
            // REDRAW
        }
    }
    
    enum starTypes {
        case round
    }
    
    
    /** The type of stars to be drawn. Defaults to `.round`.
    */
    @IBInspectable var starType: starTypes = .round
    
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
            let layer = drawStarWithFrame(randomStarFrameInFrame(bounds), boundingFrame: bounds)
            if glowingIntensity > 0.0 {
                addGlowingAnimationToStar(layer)
            }
        }
    }
    
    private func drawStarWithFrame(frame: CGRect, boundingFrame: CGRect?) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.fillColor = starColor.CGColor
        layer.path = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, frame.width, frame.height)).CGPath
        layer.backgroundColor = UIColor.clearColor().CGColor
        
        if let boundingFrame = boundingFrame {
            layer.opacity = max((Float(boundingFrame.height - frame.origin.y) / 100.0) / (Float(boundingFrame.height) / 100.0), minStarOpacity)
        }
        
        starLayer.addSublayer(layer)
        return layer
    }
    
    // MARK: Animations
    
    private func addGlowingAnimationToStar(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.duration = glowingDuration
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.autoreverses = true
        animation.repeatCount = 1000
        layer.addAnimation(animation, forKey: "shadowOpacity")
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

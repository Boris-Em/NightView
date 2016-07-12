//
//  CustomizationTableViewController.swift
//  NightViewSampleProject
//
//  Created by Bobo on 7/11/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import UIKit

class CustomizationTableViewController: UITableViewController {

    @IBOutlet weak var numberOfPointsForStarLabel: UILabel!
    @IBOutlet weak var starSizeLabel: UILabel!
    @IBOutlet weak var starSizeMinRandomizerLabel: UILabel!
    @IBOutlet weak var starSizeMaxRandomizerLabel: UILabel!
    @IBOutlet weak var minStarOpacityLabel: UILabel!
    @IBOutlet weak var glowingIntensityLabel: UILabel!
    @IBOutlet weak var glowingDurationLabel: UILabel!
    @IBOutlet weak var starTypeLabel: UILabel!
    
    @IBOutlet weak var numberOfPointsForStarSlider: UISlider!
    @IBOutlet weak var starSizeSlider: UISlider!
    @IBOutlet weak var starSizeMinRandomizerSlider: UISlider!
    @IBOutlet weak var starSizeMaxRandomizerSlider: UISlider!
    @IBOutlet weak var minStarOpacitySlider: UISlider!
    @IBOutlet weak var glowingIntensitySlider: UISlider!
    @IBOutlet weak var glowingDurationSlider: UISlider!
    @IBOutlet weak var starTypeSegmentedControl: UISegmentedControl!
    
    var nightView: NightView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Customization"
        
        if let numberOfPointsForStar = nightView?.numberOfPointsForStar {
            numberOfPointsForStarLabel.text = String(format: "%.1f", numberOfPointsForStar)
            numberOfPointsForStarSlider.value = Float(numberOfPointsForStar)
        }
        
        if let starSize = nightView?.starSize {
            starSizeLabel.text = String(format: "%.1f", starSize)
            starSizeSlider.value = Float(starSize)
        }
        
        if let starSizeMinRandomizer = nightView?.starSizeMinRandomizer {
            starSizeMinRandomizerLabel.text = String(format: "%.1f", starSizeMinRandomizer)
            starSizeMinRandomizerSlider.value = Float(starSizeMinRandomizer)
        }
        
        if let starSizeMaxRandomizer = nightView?.starSizeMaxRandomizer {
            starSizeMaxRandomizerLabel.text = String(format: "%.1f", starSizeMaxRandomizer)
            starSizeMaxRandomizerSlider.value = Float(starSizeMaxRandomizer)
        }
        
        if let minStarOpacity = nightView?.minStarOpacity {
            minStarOpacityLabel.text = String(format: "%.1f", minStarOpacity)
            minStarOpacitySlider.value = Float(minStarOpacity)
        }
        
        if let glowingIntensity = nightView?.glowingIntensity {
            glowingIntensityLabel.text = String(format: "%.1f", glowingIntensity)
            glowingIntensitySlider.value = Float(glowingIntensity)
        }
        
        if let glowingDuration = nightView?.glowingDuration {
            glowingDurationLabel.text = String(format: "%.1f", glowingDuration)
            glowingDurationSlider.value = Float(glowingDuration)
        }
        
        if let starType = nightView?.starType {
            switch starType {
            case .Round:
                starTypeSegmentedControl.selectedSegmentIndex = 0
                break
            case .FiveBranchStar:
                starTypeSegmentedControl.selectedSegmentIndex = 1
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleSlideNumberOfPointsForStarSlider(sender: UISlider) {
        nightView?.numberOfPointsForStar = CGFloat(sender.value)
        numberOfPointsForStarLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleStarSizeSlider(sender: UISlider) {
        nightView?.starSize = CGFloat(sender.value)
        starSizeLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleStarSizeMinRandomizerSlider(sender: UISlider) {
        nightView?.starSizeMinRandomizer = Double(sender.value)
        starSizeMinRandomizerLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleStarSizeMaxRandomizerSlider(sender: UISlider) {
        nightView?.starSizeMaxRandomizer = Double(sender.value)
        starSizeMaxRandomizerLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleMinStarOpacitySlider(sender: UISlider) {
        nightView?.minStarOpacity = sender.value
        minStarOpacityLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleGlowingIntensitySlider(sender: UISlider) {
        nightView?.glowingIntensity = sender.value
        glowingIntensityLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleGlowingDurationSlider(sender: UISlider) {
        nightView?.glowingDuration = Double(sender.value)
        glowingDurationLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func handleTapDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func handleStarTypeSegmentedControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            nightView?.starType = .Round
            break
        default:
            nightView?.starType = .FiveBranchStar
            break
        }
    }
}

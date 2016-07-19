# NightView

[![Build Status](https://travis-ci.org/Boris-Em/NightView.svg?branch=master)](https://travis-ci.org/Boris-Em/NightView)
[![Version](https://img.shields.io/cocoapods/v/NightView.svg?style=flat)](http://cocoadocs.org/docsets/NightView)
[![License](https://img.shields.io/cocoapods/l/NightView.svg?style=flat)](http://cocoadocs.org/docsets/NightView)
[![Platform](https://img.shields.io/cocoapods/p/NightView.svg?style=flat)](http://cocoadocs.org/docsets/NightView)

<p align="center"><img src="https://s32.postimg.org/6w9jyums5/Night_View.jpg"/></p>	

**NightView** is an open source library that generates beautiful, random, starry skies on iOS.  

## Table of Contents

* [**Project Details**](#project-details)  
  * [Requirements](#requirements)
  * [License](#license)
  * [Support](#support)
  * [Sample App](#sample-app)
* [**Getting Started**](#getting-started)
  * [Installation](#installation)
  * [Setup](#setup)
* [**Documentation**](#documentation)
 
  
  ## Project Details
Learn more about the **NightView** project, licensing, support etc.

<p align="center"><img src="https://s31.postimg.org/tn5o1yikb/Night_View_i_Phone.jpg"/></p>

### Requirements
 - Requires iOS 7 or later. The sample project is optimized for iOS 9.
 - Requires Automatic Reference Counting (ARC).
 - Optimized for ARM64 Architecture.

### License
See the [License](https://github.com/Boris-Em/NightView/blob/master/LICENSE). You are free to make changes and use this in either personal or commercial projects. Attribution is not required, but highly appreciated. A little "Thanks!" (or something to that affect) is always welcome. If you use **NightView** in your app, please let us know!

### Support
[![https://gitter.im/Boris-Em/NightView](https://badges.gitter.im/Boris-Em/NightView.svg)](https://gitter.im/Boris-Em/NightView?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)  

Join us on gitter if you have any question!

### Sample App
The iOS Sample App included with this project demonstrates one way to correctly setup and use **NightView**. It also offers the possibility to customize the view within the app.

## Getting Started
It only takes a few simple steps to install and setup **NightView** to your project.

###Installation
The easiest way to install **NightView** is to use <a href="http://cocoapods.org/" target="_blank">CocoaPods</a>. To do so, simply add the following line to your `Podfile`:
	<pre><code>pod 'NightView'</code></pre>
	
The other way to install **NightView**, is to drag and drop the *NightView* folder into your Xcode project. When you do so, make sure to check the "*Copy items into destination group's folder*" box.

### Setup
**NightView** is a simple UIView subclass. It can be initialized with Interface Builder, or programatically.
 
 **Interface Builder Initialization**  
 1 - Drag a `UIView` to your `UIViewController`.  
 2 - Change the class of the new `UIView` to `NightView`.  
 3 - Select the `NightView` and open the Attributes Inspector. Most of the customizable properties can easily be set from the Attributes Inspector. The Sample App demonstrates this capability.
 
 **Programmatical Initialization**  
 Here is an example illustrating how to initialize a NightView instance programmatically:

 ```swift
 let nightView = NightView(frame: CGRectMake(0.0, 0.0, 200.0, 200.0))
 view.addSubview(nightView)
 ```
 
## Documentation
All of the methods and properties available for **NightView** are documented below.

##### `numberOfPointsForStar`  
The number of points for each star. For example, setting this property to 1, means that there will be 1 star for every point in the view. A greater number means less stars within the view. *Defaults to 10000.0.*

##### `starSize`  
The size of the stars in points. Note that setting `starSizeMinRandomizer` and `starSizeMaxRandomizer` will also influence the size of stars. *Defaults to 5.0.*

##### `starColor`  
The color of the stars. *Defaults to white.*

##### `starSizeMinRandomizer`  
The size of the stars is randomized within the `starSize` value. This property sets the minimum percent by which the stars' size could be changed. For example, a value of 50.0 means that the minimum size of a star will be 50% of the `starSize` property. *Defaults to 50.0.*

##### `starSizeMaxRandomizer`  
The size of the stars is randomized within the `starSize` value. This property sets the maximum percent by which the stars' size could be changed. For example, a value of 150.0 means that the maximum size of a star will be 150% of the `starSize` property. *Defaults to 150.0.*  

##### `minStarOpacity`  
The stars are drawn with a smaller opacity at the bottom of the view than at the top. This property sets the minimum opacity for the lower stars. Note that the stars at the top of the view will always have an opacity of 1.0. *Defaults to 0.5.*

##### `glowingIntensity`  
The intensity of the glowing of the stars, from 0 to 1. If set to 0, the stars will not glow. *Defaults to 0.5.*

##### `glowingDuration`  
The duration in seconds at which the stars glow. *Defaults to 2.0.*

##### `starType`  
The type of stars to be drawn. *Defaults to `.Round`.*  
<p align="center"><img src="https://s32.postimg.org/5lqa389lh/Night_View_Stars.jpg"/>

##### `reload()`  
Reloads the **NightView** instance, redrawing all of the stars.

//
//  NightViewTests.swift
//  NightViewSampleProject
//
//  Created by Bobo on 7/11/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

import XCTest
@testable import NightViewSampleProject

class NightViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitWithFrame() {
        let nightView = NightView(frame: CGRectMake(0.0, 0.0, 500.0, 500.0))
        XCTAssertNotNil(nightView, "A fully initialized NightView instance should be instanciated.")
    }
    
    func testReload() {
        let nightView = NightView(frame: CGRectMake(0.0, 0.0, 500.0, 500.0))
        nightView.reload()
        let stars = nightView.layer.sublayers?.first?.sublayers
        XCTAssert(stars?.count > 0, "Multiple stars should have been drawn")
        
        nightView.reload()
        let newStars = nightView.layer.sublayers?.first?.sublayers
        XCTAssertEqual(stars?.count, newStars?.count, "After reloading, the same amount of stars should have been re-drawn")
        XCTAssertNotEqual(stars!, newStars!)

    }
    
    func testNumberOfPointsForStar() {
        let nightView = NightView(frame: CGRectMake(0.0, 0.0, 100.0, 100.0))
        nightView.reload()
        var stars = nightView.layer.sublayers?.first?.sublayers
        XCTAssert(stars?.count > 0)
        
        nightView.numberOfPointsForStar = 1
        stars = nightView.layer.sublayers?.first?.sublayers
        XCTAssertEqual(CGFloat(stars!.count), nightView.frame.size.width * nightView.frame.size.height)
    }
    
    func testStarSize() {
        let starSize: CGFloat = 100.0
        
        let nightView = NightView(frame: CGRectMake(0.0, 0.0, 50.0, 50.0))
        nightView.numberOfPointsForStar = 1
        nightView.starSize = starSize
        nightView.reload()
        var stars = nightView.layer.sublayers?.first?.sublayers
        
        var didFindBigStar = false
        var didFindSmallStar = false
        for star in stars! {
            if star.frame.size.height > starSize {
                didFindBigStar = true
            } else if star.frame.size.height < starSize {
                didFindSmallStar = true
            }
        }
        XCTAssertTrue(didFindSmallStar)
        XCTAssertTrue(didFindBigStar)
        
        
        nightView.starSizeMinRandomizer = 120.0
        nightView.starSizeMaxRandomizer = 150.0
        stars = nightView.layer.sublayers?.first?.sublayers
        
        didFindBigStar = false
        didFindSmallStar = false
        for star in stars! {
            if star.frame.size.height > starSize {
                didFindBigStar = true
            } else if star.frame.size.height < starSize {
                didFindSmallStar = true
            }
        }
        XCTAssertFalse(didFindSmallStar)
        XCTAssertTrue(didFindBigStar)

        
        nightView.starSizeMinRandomizer = 20.0
        nightView.starSizeMaxRandomizer = 80.0
        stars = nightView.layer.sublayers?.first?.sublayers
        
        didFindBigStar = false
        didFindSmallStar = false
        for star in stars! {
            if star.frame.size.height > starSize {
                didFindBigStar = true
            } else if star.frame.size.height < starSize {
                didFindSmallStar = true
            }
        }
        XCTAssertTrue(didFindSmallStar)
        XCTAssertFalse(didFindBigStar)

        
        nightView.starSizeMinRandomizer = 100.0
        nightView.starSizeMaxRandomizer = 100.0
        stars = nightView.layer.sublayers?.first?.sublayers
        
        didFindBigStar = false
        didFindSmallStar = false
        for star in stars! {
            if star.frame.size.height > starSize {
                didFindBigStar = true
            } else if star.frame.size.height < starSize {
                didFindSmallStar = true
            }
            XCTAssertEqual(star.frame.size.height, starSize)
        }
        XCTAssertFalse(didFindSmallStar)
        XCTAssertFalse(didFindBigStar)
    }
    
    func testMinStarOpacity() {
        let nightView = NightView(frame: CGRectMake(0.0, 0.0, 50.0, 50.0))
        nightView.numberOfPointsForStar = 1
        nightView.reload()
        var stars = nightView.layer.sublayers?.first?.sublayers
        
        var didFindLowOpacityStar = false
        for star in stars! {
            if star.opacity < 1.0 {
                didFindLowOpacityStar = true
                break
            }
        }
        XCTAssertTrue(didFindLowOpacityStar, "By default the stars at the bottom of the view should have a lower opacity")
        
        nightView.minStarOpacity = 1.0
        stars = nightView.layer.sublayers?.first?.sublayers
        
        didFindLowOpacityStar = false
        for star in stars! {
            if star.opacity < 1.0 {
                didFindLowOpacityStar = true
                break
            }
        }
        XCTAssertFalse(didFindLowOpacityStar, "All of the stars should have an opacity of 1")
    }

}

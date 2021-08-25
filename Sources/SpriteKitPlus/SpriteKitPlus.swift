//
//  SpriteKitPlus.swift
//
//  SpriteKitPlus is comprised of a variety of convenience methods
//  for SpriteKit based games to expedite your development process!
//
//  Created by Khiry Arnold on 8/25/21.
//  Copyright © 2021 Khatto. All rights reserved.
//

#if os(iOS)
import UIKit
#endif
import SpriteKit

extension SKAction {
    /// Returns the action with the designated timingMode
    func withTimingMode(_ timingMode: SKActionTimingMode) -> SKAction {
        self.timingMode = timingMode
        return self
    }
    
    /// Returns the action with the designated timingFunction
    func withTimingFunction(_ timingFunction: @escaping SKActionTimingFunction) -> SKAction {
        self.timingFunction = timingFunction
        return self
    }
    
    /// Repeatedly performs a fadeIn SKAction followed by a fadeOut action
    /// with .easeOut and .easeIn timingModes respectively.
    static func fadeInFadeOutForever(duration: TimeInterval = 1.0) -> SKAction {
        return SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeIn(withDuration: duration).withTimingMode(.easeOut),
            SKAction.fadeOut(withDuration: duration).withTimingMode(.easeIn),
        ]))
    }
}


extension SKTextureAtlas {
    /// Provides all of the textures in order from an SKTextureAtlas
    func getAllTextures() -> [SKTexture] {
        var textures: [SKTexture] = []
        for name in self.textureNames.sorted(by: { $0.localizedStandardCompare($1) == .orderedAscending }) {
            textures.append(self.textureNamed(name))
        }
        return textures
    }
    
    /// Provides all of the textures in order from an SKTextureAtlas
    func getAllTexturesBackwards() -> [SKTexture] {
        var textures: [SKTexture] = []
        for name in self.textureNames.sorted(by: { $0.localizedStandardCompare($1) == .orderedDescending }) {
            textures.append(self.textureNamed(name))
        }
        return textures
    }
}

extension SKSpriteNode {
    /// Returns half of the width of the sprite's frame
    var halfFrameWidth: CGFloat {
        return self.frame.width / 2.0
    }
    
    /// Returns half of the sprite's width
    var halfWidth: CGFloat {
        return self.size.width / 2.0
    }
    
    /// Returns half of the sprite's width
    var halfHeight: CGFloat {
        return self.size.height / 2.0
    }
}

extension CGRect {
    /// Returns half of the width of the CGRect as a CGFloat
    var halfWidth: CGFloat {
        return self.width / 2.0
    }
    
    /// Returns half of the height of the CGRect as a CGFloat
    var halfHeight: CGFloat {
        return self.height / 2.0
    }
    
    /// Returns a random point inside the CGRect as a CGPoint
    func randomPoint() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: minX...maxX), y: CGFloat.random(in: minY...maxY))
    }
}




#if os(iOS)
extension UIDevice {
    /// Determines if the current device has a notch
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

public extension SKLabelNode {
    /// Adds a shadow to an SKLabelNode by duplicating it and shifting the position
    func addShadow(color: UIColor, xOffset: CGFloat = 3.0, yOffset: CGFloat = -3.0) {
        let shadow = SKLabelNode(text: self.text!)
        shadow.fontColor = color
        shadow.fontName = self.fontName
        shadow.fontSize = self.fontSize
        shadow.horizontalAlignmentMode = self.horizontalAlignmentMode
        shadow.verticalAlignmentMode = self.verticalAlignmentMode
        shadow.position = CGPoint(x: xOffset, y: yOffset)
        self.addChild(shadow)
        shadow.zPosition = -1
    }
}

extension SKScene {
    
    /// The size of the scene as presented by either it's calculated bounds, or the scene's reported size
    public var presentedSize: CGSize { return view?.bounds.size ?? size }
    
    /// Returns a scale factor that's consistent with the current resolution accounting for Scaling based on width/x-axis
    private func getPresentedScaleFactorX(with initialWidth: CGFloat) -> CGFloat {
        return initialWidth / presentedSize.width
    }
    
    /// Returns a scale factor that's consistent with the current resolution accounting for Scaling based on height/y-axis
    private func getPresentedScaleFactorY(with initialHeight: CGFloat) -> CGFloat {
        return initialHeight / presentedSize.height
    }
    
    // MARK: Modern, more accurate Screen-size Calculations using Area Insets (preferable for notched devices)
    // These are for use with viewDidLayoutSubviews() in your parent UIViewController, where the
    // safeAreaInsets should be set (they more than likely won't be ready on viewDidLoad)
    // These will take into account the screen/scene sizing based on any notch influencing
    // the safeAreaInsets and will work fine if no notch is present.
    
    /// Calculates the most accurate right screen edge value taking into consideration the visible scaling for the device
    /// Currently using the areaInsets.top for the smoothest display for notched phones.
    public func getRightScreenEdgeBasedOnBounds(with initialSize: CGSize, areaInsets: UIEdgeInsets) -> CGFloat {
        guard let rightScreenEdgeBasedOnBounds = rightScreenEdgeBasedOnBounds else { return 0 }
        return rightScreenEdgeBasedOnBounds * getPresentedScaleFactorX(with: initialSize.width) - (areaInsets.top * getPresentedScaleFactorX(with: initialSize.width))
    }
    
    /// Calculates the most accurate top screen edge value taking into consideration the visible scaling for the device
    /// Currently using the areaInsets.top for the smoothest display for notched phones.  Should be less than the top.
    public func getTopScreenEdgeBasedOnBounds(with initialSize: CGSize, areaInsets: UIEdgeInsets) -> CGFloat {
        guard let topScreenEdgeBasedOnBounds = topScreenEdgeBasedOnBounds else { return 0 }
        return topScreenEdgeBasedOnBounds * getPresentedScaleFactorY(with: initialSize.height) - (areaInsets.bottom * getPresentedScaleFactorY(with: initialSize.height))
    }
    
    /// Calculates the most accurate left screen edge value taking into consideration the visible scaling for the device
    /// Currently using the areaInsets.top for the smoothest display for notched phones.
    /// Inverts the value of `getRightScreenEdgeBasedOnBounds()`
    public func getLeftScreenEdgeBasedOnBounds(with initialSize: CGSize, areaInsets: UIEdgeInsets) -> CGFloat {
        return -getRightScreenEdgeBasedOnBounds(with: initialSize, areaInsets: areaInsets)
    }
    
    /// Calculates the most accurate bottom screen edge value taking into consideration the visible scaling for the device
    /// Currently using the areaInsets.top for the smoothest display for notched phones.  Should be less than the top.
    /// Inverts the value of `getBottomScreenEdgeBasedOnBounds()`
    public func getBottomScreenEdgeBasedOnBounds(with initialSize: CGSize, areaInsets: UIEdgeInsets) -> CGFloat {
        return -getTopScreenEdgeBasedOnBounds(with: initialSize, areaInsets: areaInsets)
    }
    
    /// Obtains half of the presented screen width to define the right edge
    private var rightScreenEdgeBasedOnBounds: CGFloat? {
        return presentedSize.width / 2.0
    }
    
    /// Obtains half of the presented screen height to define the right edge
    private var topScreenEdgeBasedOnBounds: CGFloat? {
        return presentedSize.height / 2.0
    }
    
    // MARK: Simplistic, legacy Screen-size Calculations (works fine for non-notched devices)
    
    /// Provides half the width of the device's screen
    public var halfScreenWidth: CGFloat {
        return self.size.width / 2.0
    }
    
    /// Provides half the height of the device's screen
    public var halfScreenHeight: CGFloat {
        return self.size.height / 2.0
    }
    
    /// Returns the left-most x position of the screen
    public var leftScreenEdge: CGFloat {
        return -halfScreenWidth
    }
    
    /// Returns the right-most x position of the screen
    public var rightScreenEdge: CGFloat {
        return halfScreenWidth
    }
    
    /// Returns the bottom-most y position of the screen
    public var bottomScreenEdge: CGFloat {
        return -halfScreenHeight
    }
    
    /// Returns the top-most y position of the screen
    public var topScreenEdge: CGFloat {
        return halfScreenHeight
    }
    
    /// Determines whether or not a specific point is within the bounds of a designated percentage of the screen size
    public func withinScreenPercentageFromCenter(xPercentage: CGFloat, yPercentage: CGFloat, point: CGPoint, initialSize: CGSize, areaInsets: UIEdgeInsets?) -> Bool {
        
        if let areaInsets = areaInsets {
            let rightScreenEdge = getRightScreenEdgeBasedOnBounds(with: initialSize, areaInsets: areaInsets)
            let topScreenEdge = getTopScreenEdgeBasedOnBounds(with: initialSize, areaInsets: areaInsets)
            let leftScreenEdge = -rightScreenEdge
            let bottomScreenEdge = -topScreenEdge
            
            if point.x <= rightScreenEdge * xPercentage, point.x >= leftScreenEdge * xPercentage, point.y <= topScreenEdge * yPercentage, point.y >= bottomScreenEdge * yPercentage {
                return true
            }
        }
        
        return false
    }
    
    public func sizeProportionalToSceneWidth(currentSize: CGSize, desiredPercent: CGFloat) -> CGSize? {
        guard let sceneWidth = scene?.frame.width else { return nil }
        
        let shrinkPercentage = (sceneWidth * desiredPercent) / currentSize.width
        let aspectRatio = currentSize.height / currentSize.width
        let newWidth = currentSize.width * shrinkPercentage
        
        return CGSize(width: newWidth, height: newWidth * aspectRatio)
    }
}

#endif

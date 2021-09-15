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
    public func withTimingMode(_ timingMode: SKActionTimingMode) -> SKAction {
        self.timingMode = timingMode
        return self
    }
    
    /// Returns the action with the designated timingFunction
    public func withTimingFunction(_ timingFunction: @escaping SKActionTimingFunction) -> SKAction {
        self.timingFunction = timingFunction
        return self
    }
    
    /// Repeatedly performs a fadeIn SKAction followed by a fadeOut action
    /// with .easeOut and .easeIn timingModes respectively.
    static public func fadeInFadeOutForever(duration: TimeInterval = 1.0) -> SKAction {
        return SKAction.repeatForever(SKAction.sequence([
            SKAction.fadeIn(withDuration: duration).withTimingMode(.easeOut),
            SKAction.fadeOut(withDuration: duration).withTimingMode(.easeIn),
        ]))
    }
}


extension SKTextureAtlas {
    
    /// Provides all of the textures in order from an SKTextureAtlas
    public func getAllTextures() -> [SKTexture] {
        var textures: [SKTexture] = []
        for name in self.textureNames.sorted(by: { $0.localizedStandardCompare($1) == .orderedAscending }) {
            textures.append(self.textureNamed(name))
        }
        return textures
    }
    
    /// Provides all of the textures in order from an SKTextureAtlas
    public func getAllTexturesBackwards() -> [SKTexture] {
        var textures: [SKTexture] = []
        for name in self.textureNames.sorted(by: { $0.localizedStandardCompare($1) == .orderedDescending }) {
            textures.append(self.textureNamed(name))
        }
        return textures
    }
}

extension SKSpriteNode {
    
    /// Returns half of the width of the sprite's frame
    public var halfFrameWidth: CGFloat {
        return self.frame.width / 2.0
    }
    
    /// Returns half of the sprite's width
    public var halfWidth: CGFloat {
        return self.size.width / 2.0
    }
    
    /// Returns half of the sprite's width
    public var halfHeight: CGFloat {
        return self.size.height / 2.0
    }
    
    /// Aligns the top of this node to the bottom of a designated node, taking into account the anchor
    public func alignTopToBottomOfNode(node: SKNode) {
        let nodeBottom = node.frame.minY
        self.position.y = nodeBottom - self.anchorPoint.y * self.frame.height
    }
    
    /// Aligns the bottom of this node to the top of a designated node, taking into account the anchor
    public func alignBottomToTopOfNode(node: SKNode) {
        let nodeTop = node.frame.maxY
        self.position.y = nodeTop + self.anchorPoint.y * self.frame.height
    }
    
    /// Aligns the right edge of this node to the left edge of a designated node, taking into account the anchor
    public func alignRightEdgeToLeftEdgeOfNode(node: SKNode) {
        let nodeLeft = node.frame.minX
        self.position.x = nodeLeft - self.anchorPoint.x * self.frame.width
    }
    
    /// Aligns the right edge of this node to the left edge of a designated node, taking into account the anchor
    public func alignLeftEdgeToRightEdgeOfNode(node: SKNode) {
        let nodeRight = node.frame.maxX
        self.position.x = nodeRight + self.anchorPoint.x * self.frame.width
    }
    
    /// Aligns the bottom edge of this node to the bottom edge of a designated node, taking into account the anchor
    public func alignBottomEdgeToNodesBottomEdge(node: SKNode) {
        self.position.y = node.frame.minY + self.anchorPoint.y * self.frame.height
    }
    
    /// Aligns the top edge of this node to the top edge of a designated node, taking into account the anchor
    public func alignTopEdgeToNodesTopEdge(node: SKNode) {
        self.position.y = node.frame.maxY - self.anchorPoint.y * self.frame.height
    }
}

extension CGRect {
    
    /// Returns half of the width of the CGRect as a CGFloat
    public var halfWidth: CGFloat {
        return self.width / 2.0
    }
    
    /// Returns half of the height of the CGRect as a CGFloat
    public var halfHeight: CGFloat {
        return self.height / 2.0
    }
    
    /// Returns a random point inside the CGRect as a CGPoint
    public func randomPoint() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: minX...maxX), y: CGFloat.random(in: minY...maxY))
    }
}

extension CGFloat {
    /// Returns half of the current value
    public var half: CGFloat {
        return self / 2.0
    }
    
    /// Returns 1/3 the current value
    public var third: CGFloat {
        return self / 3.0
    }
    
    /// Returns 1/4 of the current value
    public var quarter: CGFloat {
        return self / 4.0
    }
    
    /// Returns double the current value
    public var double: CGFloat {
        return self * 2.0
    }
    
    /// Returns triple the current value
    public var triple: CGFloat {
        return self * 3.0
    }
    
    /// Returns double the current value
    public var quadruple: CGFloat {
        return self * 4.0
    }
    
    /// Returns 3/4 the current value
    public var threeFourths: CGFloat {
        return self * 3.0 / 4.0
    }
    
    /// Returns 3/5 the current value
    public var threeFifths: CGFloat {
        return self * 3.0 / 5.0
    }
    
    /// Returns 4/5 the current value
    public var fourFifths: CGFloat {
        return self * 4.0 / 5.0
    }
    
    /// Returns a value of 0.0 to ensure a completely hidden alpha value
    public var hidden: CGFloat {
        return 0
    }
    
    /// Returns a value of 1.0 to ensure a completely visible alpha value
    public var visible: CGFloat {
        return 1
    }
}

#if os(iOS)

extension UIWindow {
    
    static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows
                .first?
                .windowScene?
                .interfaceOrientation
                .isLandscape ?? false
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}

extension UIDevice {
    
    /// Determines if the current device has a notch
    public var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension UIColor {
    
    /// Provides a simple tuple for getting the rgba values from a UIColor
    public var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    /// Allows for initializing a UIColor with a hex string (must begin with '#')
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            } else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
    
    /// Converts a UIColor to a hex string, including alpha
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
        return String(format: "#%06x", rgb)
    }
}

public extension SKLabelNode {
    
    /// Adds a shadow to an SKLabelNode by duplicating it and shifting the position
    public func addShadow(color: UIColor, xOffset: CGFloat = 3.0, yOffset: CGFloat = -3.0) {
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
    /*
     These are for use with viewDidLayoutSubviews() in your parent UIViewController, where the safeAreaInsets should be set (they more than likely won't be ready on viewDidLoad). These will take into account the screen/scene sizing based on any notch influencing the safeAreaInsets and will work fine if no notch is present.
     */
    
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
        /// Ensures the visual integrity of elements aligned to the edge of the screen in landscape on notched devices
        let landscapeEdgeAlignmentModifier: CGFloat = 3
        return topScreenEdgeBasedOnBounds * getPresentedScaleFactorY(with: initialSize.height) - (areaInsets.bottom * getPresentedScaleFactorY(with: initialSize.height)) - (UIWindow.isLandscape ? areaInsets.right - landscapeEdgeAlignmentModifier : 0)
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
    
    /// Returns a size that features a scale relative to the scene's width, based on the desiredPercent while preserving aspect ratio
    public func scaleProportionalToSceneWidth(currentSize: CGSize, desiredPercent: CGFloat) -> CGSize? {
        guard let sceneWidth = scene?.frame.width else { return nil }
        
        let shrinkPercentage = (sceneWidth * desiredPercent) / currentSize.width
        let aspectRatio = currentSize.height / currentSize.width
        let newWidth = currentSize.width * shrinkPercentage
        
        return CGSize(width: newWidth, height: newWidth * aspectRatio)
    }
    
    /// Provides a size from a reference that is scaled to stretch to the size of the scene's width
    public func sizeWithWidthScaledToSceneWidth(currentSize: CGSize) -> CGSize? {
        guard let sceneWidth = scene?.frame.width else { return nil }
        
        let scale = (sceneWidth / currentSize.width)
        let newWidth = currentSize.width * scale
        
        return CGSize(width: newWidth, height: currentSize.height)
    }
    
    /// Provides a size from a reference that is scaled to stretch to the size of the scene's height
    public func sizeWithHeightScaledToSceneHeight(currentSize: CGSize) -> CGSize? {
        guard let sceneHeight = scene?.frame.height else { return nil }
        
        let scale = (sceneHeight / currentSize.height)
        let newHeight = currentSize.height * scale
        
        return CGSize(width: currentSize.width, height: newHeight)
    }
    
    /// Provides an x and y scale from a reference that is scaled to stretch to the size of the scene's height
    public func scaleWidthAndHeightToPercentagesOfScene(currentSize: CGSize, desiredWidthPercent: CGFloat, desiredHeightPercent: CGFloat) -> (xScale: CGFloat, yScale: CGFloat)? {
        guard let sceneWidth = scene?.frame.width, let sceneHeight = scene?.frame.height else { return nil }
        
        let xScale = (sceneWidth * desiredWidthPercent / currentSize.width)
        let yScale = (sceneHeight * desiredHeightPercent / currentSize.height)
        
        return (xScale: xScale, yScale: yScale)
    }
    
    /// Provides a size from a reference that is scaled to stretch to the size of the scene's height
    public func getSizeBasedOnPercentagesOfScene(currentSize: CGSize, desiredWidthPercent: CGFloat, desiredHeightPercent: CGFloat) -> CGSize? {
        guard let sceneWidth = scene?.frame.width, let sceneHeight = scene?.frame.height else { return nil }
        
        let xScale = (sceneWidth * desiredWidthPercent / currentSize.width)
        let yScale = (sceneHeight * desiredHeightPercent / currentSize.height)
        
        return CGSize(width: currentSize.width * xScale, height: currentSize.height * yScale)
    }
}

#endif

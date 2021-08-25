# SpriteKitPlus

## Introduction

> Expedite your development time with this bounty of convenience methods made specifically for SpriteKit!  Quickly access half and full widths and heights of varying SKNodes, create an SKAction with a designated timingMode in one line, and more!

## Code Samples

> Craft an SKAction with a SKActionTimingMode with the following function in one line:

>```
func withTimingMode(_ timingMode: SKActionTimingMode) -> SKAction {
    self.timingMode = timingMode
    return self
}```

> For example:
> ```
let action = SKAction.fadeIn(withDuration: 1.0).withTimingMode(.easeInEaseOut)
```

## Installation

> TBD.  But will be using Swift Package Manager.

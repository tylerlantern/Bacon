//
//  Miscellaneous.swift
//  TradeJewelry
//
//  Created by Nattapong Unaregul on 25/3/2558 BE.
//  Copyright (c) 2558 Nattapong. All rights reserved.
//

import Foundation
import UIKit

enum ScrollDirection   {
    case ScrollDirectionNone
    case ScrollDirectionCrazy
    case ScrollDirectionLeft
    case ScrollDirectionRight
    case ScrollDirectionUp
    case ScrollDirectionDown
    case ScrollDirectionHorizontal
    case ScrollDirectionVertical
    func description() ->String{
        switch self {
        case .ScrollDirectionRight :
            return "right"
        case .ScrollDirectionLeft :
            return "left"
        case .ScrollDirectionUp :
            return "up"
        case .ScrollDirectionDown :
            return "down"
        default : return "none"
        }
    }
}

extension UIColor {
    
    static func randomColor() -> UIColor {
        let r = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}




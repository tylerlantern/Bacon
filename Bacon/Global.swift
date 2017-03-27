//
//  Global.swift
//  Bacon
//
//  Created by Nattapong Unaregul on 3/18/2560 BE.
//  Copyright © 2560 Nattapong Unaregul. All rights reserved.
//

import Foundation
class GlobalParams : NSObject {
    
    let currentcyIdentifier = "th_TH"
    let http_api = "http://api.trade-jewelry.com/api"
    let http_apiForRender = "http://api.trade-jewelry.com"
    let fontfamilyname = "HelveticaNeue"
    
    static let sharedInstance = GlobalParams()
}

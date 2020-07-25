//
//  Utils.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation
import UIKit

private var utils: Utils? = nil

class Utils: NSObject {
    
    class func singleInstanceUtils() -> Utils {
        if utils == nil {
            utils = Utils()
        }
        return utils ?? Utils()
    }

    // MARK: - Check Internet Availability
    class func isInternetAvailable() -> Bool {
        return ServiceManager.shared.isInternetAvailable
    }

}

//
//  CommonFunctions.swift
//  Wallet App UI
//
//  Created by Yash Shah on 03/03/22.
//

import Foundation
import UIKit

public final class CommonFunctions {
    
    public static func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
}

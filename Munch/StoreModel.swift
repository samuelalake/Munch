//
//  StoreManager.swift
//  Munch
//
//  Created by Samuel Alake on 6/7/22.
//

import Foundation
import UIKit
import CareKit
import CareKitStore

class StoreModel: NSObject{
    private(set) var storeManager = OCKSynchronizedStoreManager(
        wrapping: OCKStore(
            name: "com.apple.wwdc.carekitstore",
            type: .inMemory
        )
    )
    
    static let shared = StoreModel()
    
}

//
//  GroceryViewRepresentable.swift
//  Munch
//
//  Created by Samuel Alake on 6/8/22.
//

import Foundation
import SwiftUI
import UIKit
import CareKitStore
import CareKit

struct GroceryViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
        
    func updateUIViewController(_ taskViewController: UIViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> UIViewController {
        let storeManager = StoreModel.shared.storeManager
//        let storeManager = OCKSynchronizedStoreManager(
//            wrapping: OCKStore(
//                name: "com.apple.wwdc.carekitstore",
//                type: .inMemory
//            )
//        )
        
        let vc = GroceryViewController(storeManager: storeManager)
        return UINavigationController(rootViewController: vc)
    }
    
}

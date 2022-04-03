//
//  RecipesViewControllerRepresentable.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import Foundation
import SwiftUI
import UIKit
import CareKitStore
import CareKit

struct RecipesViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
        
    func updateUIViewController(_ taskViewController: UIViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> UIViewController {
        let storeManager = OCKSynchronizedStoreManager(
            wrapping: OCKStore(
                name: "com.apple.wwdc.carekitstore",
                type: .inMemory
            )
        )
        
        let vc = RecipesViewController(storeManager: storeManager)
        return UINavigationController(rootViewController: vc)
    }
    
}

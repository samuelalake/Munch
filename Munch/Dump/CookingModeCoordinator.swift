//
//  CookingModeCoordinator.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import Foundation
import ResearchKit

class CookingModeCoordinator: NSObject, ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        taskViewController.dismiss(animated: true, completion: nil)
    }
}

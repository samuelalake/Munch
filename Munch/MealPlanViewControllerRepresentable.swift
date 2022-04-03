//
//  MealPlanViewController.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import SwiftUI
import UIKit
import ResearchKit
import CareKit
import CareKitUI
import CareKitStore
import os.log

struct MealPlanViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
        
        func updateUIViewController(_ taskViewController: UIViewController, context: Context) {}
        func makeUIViewController(context: Context) -> UIViewController {
            let storeManager = OCKSynchronizedStoreManager(
                wrapping: OCKStore(
                    name: "com.apple.wwdc.carekitstore",
                    type: .inMemory
                )
            )
            
            let mealPlanSchedule = OCKSchedule.dailyAtTime(
                hour: 8,
                minutes: 0,
                start: Date(),
                end: nil,
                text: nil
                //duration: .allDay
            )
            
            let mealPlanTask = OCKTask(
                id: TaskIDs.mealPlan,
                title: "Wonton Noodle Stir-Fry",
                carePlanUUID: nil,
                schedule: mealPlanSchedule
            )
            
            storeManager.store.addAnyTasks([mealPlanTask], callbackQueue: .main) { result in
                
                switch result{
                case let .success(tasks):
                    Logger.store.info("Seeded \(tasks.count) tasks")
                case let .failure(error):
                    Logger.store.warning("Failed to seed tasks: \(error as NSError)")
                }
            }
            
            let vc = MealPlanViewController(storeManager: storeManager)
            return UINavigationController(rootViewController: vc)
        }
    
    
    
}

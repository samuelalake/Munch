//
//  CookingModeController.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import SwiftUI
import UIKit
import ResearchKit

struct CookingModeController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> CookingModeCoordinator {
        CookingModeCoordinator()
    }
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {}
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {

        /* **************************************************************
        *  Welcome. Introduce Recipe Screen
        **************************************************************/
        
        let welcomeInstructionStep = ORKInstructionStep(
            identifier: "onboarding.welcome"
        )
        
        welcomeInstructionStep.title = "Welcome!"
        welcomeInstructionStep.detailText = "Thank you for joining our study. Tap Next to learn more before signing up."
        welcomeInstructionStep.image = UIImage(named: "welcome-image")
        let welcomeBodyItem = ORKBodyItem(
            text: "The study will ask you to share some of your Health data.",
            detailText: nil,
            image: UIImage(systemName: "heart.fill"),
            learnMoreItem: nil,
            bodyItemStyle: .image
        )
        welcomeInstructionStep.bodyItems = [
            welcomeBodyItem
        ]
        
        /* **************************************************************
        *  Recipe Tasks
        **************************************************************/
        
        let studyOverviewInstructionStep = ORKInstructionStep(identifier: "onboarding-overview")
        
        studyOverviewInstructionStep.title = "Cook the eggs:"
        studyOverviewInstructionStep.image = UIImage(named: "before-you-join")
        
        studyOverviewInstructionStep.detailText = "Fill a medium pot 3/4 of the way up with water; cover and heat to boiling on high. Once boiling, carefully add the eggs and cook 7 minutes for soft-boiled, or until your desired degree of doneness. Leaving the pot of water boiling, using a slotted spoon or tongs, carefully transfer the eggs to a strainer. Rinse under cold water 30 seconds to 1 minute to stop the cooking process. When cool enough to handle, peel the cooked eggs. Season with salt and pepper."
        
        /* **************************************************************
        *  Recipe Completion
        **************************************************************/
        
        //1.4.5 Completion Step
        
        let completionStep = ORKCompletionStep(identifier: "onboarding.completionStep")
        completionStep.title = "Enrollment Complete"
        completionStep.text = "Thanks for enrolling!"
        
        /* **************************************************************
        * Create an array with the steps to show the user
        **************************************************************/
        
        // given intro steps that the user should review and consent to
        let stepsToUse: [ORKStep] = [welcomeInstructionStep, studyOverviewInstructionStep, completionStep]
        
        /* **************************************************************
        * Show the user these steps
        **************************************************************/
        // create a task with each step
        let orderedTask = ORKOrderedTask(identifier: "CookingModeTask", steps: stepsToUse)
        
        // wrap that task on a view controller
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
        taskViewController.delegate = context.coordinator
        
        // & present the VC!
        return taskViewController
    }
    
}

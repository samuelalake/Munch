//
//  Surveys.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import CareKitStore
import ResearchKit
import HealthKit
import CareKitUI
import CareKit

struct Surveys {

    private init() {}

    // MARK: Onboarding

    // 1.4 Construct an ORKTask for onboarding
    static func cookingMode() -> ORKTask{
        /* **************************************************************
        *  Welcome. Introduce Recipe Screen
        **************************************************************/
        
        let welcomeInstructionStep = ORKInstructionStep(
            identifier: "onboarding.welcome"
        )
        
        welcomeInstructionStep.title = "Wonton Noodle Stir Fry"
        welcomeInstructionStep.detailText = "In this easy, Asian-inspired recipe, we’re making a sweet and spicy sauce to coat fresh wonton noodles, crisp celery, and tender peppers and zucchini—first cooked with our fragrant blend of sautéed aromatics for a boost of bright flavor. The rich yolks from soft-boiled eggs provide the perfect finishing touch to the dish."
        welcomeInstructionStep.image = UIImage(named: "wonton")
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
        welcomeInstructionStep.imageContentMode = .scaleAspectFill
        
        /* **************************************************************
        *  Recipe Tasks
        **************************************************************/
        
        let studyOverviewInstructionStep = ORKInstructionStep(identifier: "onboarding-overview")
        
        studyOverviewInstructionStep.title = "Cook the eggs:"
        studyOverviewInstructionStep.image = UIImage(named: "wonton")
        
        studyOverviewInstructionStep.detailText = "Fill a medium pot 3/4 of the way up with water; cover and heat to boiling on high. Once boiling, carefully add the eggs and cook 7 minutes for soft-boiled, or until your desired degree of doneness. Leaving the pot of water boiling, using a slotted spoon or tongs, carefully transfer the eggs to a strainer. Rinse under cold water 30 seconds to 1 minute to stop the cooking process. When cool enough to handle, peel the cooked eggs. Season with salt and pepper."
        
        /* **************************************************************
        *  Recipe Completion
        **************************************************************/
        
        //1.4.5 Completion Step
        
        let completionStep = ORKCompletionStep(identifier: "onboarding.completionStep")
        completionStep.title = "Cooking Complete"
        completionStep.text = "Thanks for cooking!"
        
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
        
//        // wrap that task on a view controller
//        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
//        taskViewController.delegate = context.coordinator
//
//        // & present the VC!
//        return taskViewController
        
        return orderedTask
    }
    
    // MARK: 3D Knee Model
    
    static func kneeModel() -> ORKTask {

        let instructionStep = ORKInstructionStep(
            identifier: "insights.instructionStep"
        )
        instructionStep.title = "Your Injury Visualized"
        instructionStep.detailText = "A 3D model will be presented to give you better insights on your specific injury."
        instructionStep.iconImage = UIImage(systemName: "bandage")

        let modelManager = ORKUSDZModelManager(usdzFileName: "toy_robot_vintage")

        let kneeModelStep = ORK3DModelStep(
            identifier: "insights.kneeModel",
            modelManager: modelManager
        )

        let kneeModelTask = ORKOrderedTask(
            identifier: "insights",
            steps: [instructionStep, kneeModelStep]
        )

        return kneeModelTask
    }
    
    static func recipeDetailView() -> OCKDetailViewController {
        let recipeView = OCKDetailViewController(html: nil, imageOverlayStyle: .dark, showsCloseButton: true)
        recipeView.detailView.imageView.image = UIImage(named: "wonton")
        return recipeView
    }

    
}

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

    // MARK: Add Recipe Form
    static func addRecipe() -> ORKTask{
        var recipeSteps: [ORKStep] = []
        
        let imageUploadStep = ORKImageCaptureStep(identifier: "add.image")
        recipeSteps += [imageUploadStep]

        let titleAnswerFormat = ORKAnswerFormat.textAnswerFormat()
        titleAnswerFormat.placeholder = "recipe title"
        
        let titleItem = ORKFormItem(identifier: "recipeTitle", text: "Title", answerFormat: titleAnswerFormat)
        
        let descriptionAnswerFormat = ORKAnswerFormat.textAnswerFormat()
        descriptionAnswerFormat.placeholder = "description"
        descriptionAnswerFormat.multipleLines = true
        
        let descriptionItem = ORKFormItem(identifier: "recipeDescription", text: "Description", answerFormat: descriptionAnswerFormat)
        
        let ingredientAnswerFormat = ORKAnswerFormat.textAnswerFormat()
        ingredientAnswerFormat.placeholder = "ingredient"
        ingredientAnswerFormat.multipleLines = true
        
        let ingredientItem = ORKFormItem(identifier: "recipeIngredients", text: "Ingredient", answerFormat: ingredientAnswerFormat)
        
        let instructionsAnswerFormat = ORKAnswerFormat.textAnswerFormat()
        instructionsAnswerFormat.placeholder = "instructions"
        instructionsAnswerFormat.multipleLines = true
        
        let instructionsItem = ORKFormItem(identifier: "recipeInstructions", text: "Instructions", answerFormat: instructionsAnswerFormat)
        
        let recipeInfoStep = ORKFormStep(identifier: "add.recipeInfo", title: "Add recipe information", text: "Include recipe details")
        
        recipeInfoStep.formItems = [titleItem, descriptionItem, ingredientItem, instructionsItem]
        recipeInfoStep.isOptional = false
        
        let addRecipeTask = ORKOrderedTask(identifier: "addRecipeTask", steps: [imageUploadStep, recipeInfoStep])
        
        return addRecipeTask
        
        //event.answer(kind: checkInIdentifier)
    }
    
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
        
        
        //let uploadImage = ORKImageCaptureStep(identifier: "image") (important to remember)
        
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
    
        static let checkInIdentifier = "checkin"
        static let checkInFormIdentifier = "checkin.form"
        static let checkInPainItemIdentifier = "checkin.form.pain"
        static let checkInSleepItemIdentifier = "checkin.form.sleep"

        static func checkInSurvey() -> ORKTask {

            let painAnswerFormat = ORKAnswerFormat.scale(
                withMaximumValue: 10,
                minimumValue: 1,
                defaultValue: 0,
                step: 1,
                vertical: false,
                maximumValueDescription: "Very painful",
                minimumValueDescription: "No pain"
            )

            let sleepAnswerFormat = ORKAnswerFormat.scale(
                withMaximumValue: 12,
                minimumValue: 0,
                defaultValue: 0,
                step: 1,
                vertical: false,
                maximumValueDescription: nil,
                minimumValueDescription: nil
            )

            let painItem = ORKFormItem(
                identifier: checkInPainItemIdentifier,
                text: "How would you rate your pain?",
                answerFormat: painAnswerFormat
            )
            painItem.isOptional = false

            let sleepItem = ORKFormItem(
                identifier: checkInSleepItemIdentifier,
                text: "How many hours of sleep did you get last night?",
                answerFormat: sleepAnswerFormat
            )
            sleepItem.isOptional = false

            let formStep = ORKFormStep(
                identifier: checkInFormIdentifier,
                title: "Check In",
                text: "Please answer the following questions."
            )
            formStep.formItems = [painItem, sleepItem]
            formStep.isOptional = false

            let surveyTask = ORKOrderedTask(
                identifier: checkInIdentifier,
                steps: [formStep]
            )

            return surveyTask
        }
    
    
    static func recipeDetailView() -> OCKDetailViewController {
        let recipeView = OCKDetailViewController(html: nil, imageOverlayStyle: .dark, showsCloseButton: true)
        recipeView.detailView.imageView.image = UIImage(named: "wonton")
        //recipeView.detailView.contentStackView =
        
        let label = OCKLabel(textStyle: .body, weight: .bold)
        label.text = "Hello"
        
        recipeView.detailView.bodyLabel.text = "Hello"
        return recipeView
        
    }

    
}

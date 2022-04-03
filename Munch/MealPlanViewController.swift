//
//  MealPlanViewCoordinator.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import Foundation
import ResearchKit
import CareKit
import CareKitStore
import CareKitUI

class MealPlanViewController: OCKDailyPageViewController, OCKSurveyTaskViewControllerDelegate{
    
    override func viewDidLoad() {
            super.viewDidLoad()
            title = "Meal Plan"
        }
    
    override func dailyPageViewController(
        _ dailyPageViewController: OCKDailyPageViewController,
        prepare listViewController: OCKListViewController,
        for date: Date) {
            
            let isFuture = Calendar.current.compare(
                date,
                to: Date(),
                toGranularity: .day) == .orderedDescending

            self.fetchTasks(on: date) { tasks in
                tasks.compactMap {

                    let card = self.taskViewController(for: $0, on: date)
                    card?.view.isUserInteractionEnabled = !isFuture
                    card?.view.alpha = isFuture ? 0.4 : 1.0

                    return card

                }.forEach {
                    listViewController.appendViewController($0, animated: false)
                }
            }
        }
    
    // MARK: SurveyTaskViewControllerDelegate
    
    func surveyTask(
        viewController: OCKSurveyTaskViewController,
        for task: OCKAnyTask,
        didFinish result: Result<ORKTaskViewControllerFinishReason, Error>) {

        if case let .success(reason) = result, reason == .completed {
            reload()
        }
    }
    
    func surveyTask(
        viewController: OCKSurveyTaskViewController,
        shouldAllowDeletingOutcomeForEvent event: OCKAnyEvent) -> Bool {

        event.scheduleEvent.start >= Calendar.current.startOfDay(for: Date())
    }
    
    private func fetchTasks(
        on date: Date,
        completion: @escaping([OCKAnyTask]) -> Void) {

        var query = OCKTaskQuery(for: date)
        query.excludesTasksWithNoEvents = true

        storeManager.store.fetchAnyTasks(
            query: query,
            callbackQueue: .main) { result in

            switch result {

            case .failure:
                Logger.feed.error("Failed to fetch tasks for date \(date)")
                completion([])

            case let .success(tasks):
                completion(tasks)
            }
        }
    }

    //2.4 Create a card for a given task
    private func taskViewController(
        for task: OCKAnyTask,
        on date: Date) -> UIViewController? {

        switch task.id {

        case TaskIDs.mealPlan:

            let survey = OCKSurveyTaskViewController(
                task: task,
                eventQuery: OCKEventQuery(for: date),
                storeManager: storeManager,
                survey: Surveys.cookingMode(),
                extractOutcome: { _ in [OCKOutcomeValue(Date())] }
            )
            //survey.taskView.completionButton.label.text = "Cook Now"

            return survey

        default:
            return nil
        }
    }
    
}

final class SurveyViewSynchronizer: OCKSurveyTaskViewSynchronizer {

    override func makeView() -> OCKInstructionsTaskView {
            let instructionsView = super.makeView()
            instructionsView.completionButton.label.text = "Start"
            return instructionsView
    }
    
    override func updateView(
        _ view: OCKInstructionsTaskView,
        context: OCKSynchronizationContext<OCKTaskEvents>) {

        super.updateView(view, context: context)
            
            //view.completionButton.label.text = "Cook Now"

        if let event = context.viewModel.first?.first, event.outcome != nil {
//            view.instructionsLabel.isHidden = false
//
//            let pain = event.answer(kind: Surveys.checkInPainItemIdentifier)
//            let sleep = event.answer(kind: Surveys.checkInSleepItemIdentifier)
//
//            view.instructionsLabel.text = """
//                Pain: \(Int(pain))
//                Sleep: \(Int(sleep)) hours
//                """
            view.completionButton.label.text = "Completed"
        } else {
            //view.instructionsLabel.isHidden = true
            view.completionButton.label.text = "Cook Now"
        }
    }
}


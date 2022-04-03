//
//  CareFeedViewController.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import CareKit
import CareKitStore
import CareKitUI
import ResearchKit
import UIKit
import os.log

final class CareFeedViewController: OCKDailyPageViewController,
                                    OCKSurveyTaskViewControllerDelegate {

    override func dailyPageViewController(
        _ dailyPageViewController: OCKDailyPageViewController,
        prepare listViewController: OCKListViewController,
        for date: Date) {
            
            self.fetchTasks(on: date){ tasks in
                tasks.compactMap{
                    self.taskViewController(for: $0, on: date)
                }.forEach{
                    listViewController.appendViewController($0, animated: false)
                }
            }

//        // 1.3 Check if onboarding is complete.
//            checkIfOnboardingIsComplete{ isOnboarded in
//
//                //1.4 If it isn't complete, show an onboarding card.
//                guard isOnboarded else {
//                    let onboardCard = OCKSurveyTaskViewController(
//                        taskID: TaskIDs.onboarding,
//                        eventQuery: OCKEventQuery(for: date),
//                        storeManager: self.storeManager,
//                        survey: Surveys.onboardingSurvey(),
//                        extractOutcome: { _ in [OCKOutcomeValue(Date())] }
//                    )
//
//                    onboardCard.surveyDelegate = self
//
//                    listViewController.appendViewController(
//                        onboardCard,
//                        animated: false
//                    )
//
//                    return
//                }
//
//        // 1.5 If it is, show all other cards
//                //2.2 Query and display a card for each task
//                self.fetchTasks(on: date){ tasks in
//                    tasks.compactMap{
//                        self.taskViewController(for: $0, on: date)
//                    }.forEach{
//                        listViewController.appendViewController($0, animated: false)
//                    }
//                }
//            }
//
    }

    // 1.2 Define a method that checks if onboarding is complete
    private func checkIfOnboardingIsComplete(_ completion: @escaping (Bool) -> Void) {
        
        var query = OCKOutcomeQuery()
        query.taskIDs = [TaskIDs.onboarding]
        
        storeManager.store.fetchAnyOutcome(
            query: query,
            callbackQueue: .main) { result in
                
                switch result{
                    
                case .failure:
                    Logger.feed.error("Failed to fetch onboarding outcomes!")
                    completion(false)
                    
                case .success(_): //let .success(outcomes)
                    completion(true)
                    //!outcomes.isEmpty
                    
//                case let .success(outcomes):
//                    completion(!outcomes.isEmpty)
                }
                
            
            }
    }

    // 1.6 Refresh the content when onboarding completes
    
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

        case TaskIDs.checkIn:

            let survey = OCKSurveyTaskViewController(
                task: task,
                eventQuery: OCKEventQuery(for: date),
                storeManager: storeManager,
                survey: Surveys.cookingMode(),
                extractOutcome: { _ in [OCKOutcomeValue(Date())] }
            )

            return survey

//        case TaskIDs.rangeOfMotionCheck:
//            let survey = OCKSurveyTaskViewController(
//                task: task,
//                eventQuery: OCKEventQuery(for: date),
//                storeManager: storeManager,
//                survey: Surveys.rangeOfMotionCheck(),
//                extractOutcome: Surveys.extractRangeOfMotionOutcome
//            )
//
//            return survey

        default:
            return nil
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
}


//
//  GroceryViewController.swift
//  Munch
//
//  Created by Samuel Alake on 6/8/22.
//

import SwiftUI
import CareKit
import CareKitUI
import ResearchKit

class GroceryViewController: OCKListViewController, ORKTaskViewControllerDelegate {
    
    let storeManager: OCKSynchronizedStoreManager

    init(storeManager: OCKSynchronizedStoreManager) {
        self.storeManager = storeManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func didTapView(_ view: OCKFeaturedContentView) {
//
//        let detailViewController = Surveys.recipeDetailView()
//
//        present(detailViewController, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Grocery"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        
    }
    
    // MARK: ORKTaskViewControllerDelegate

    func taskViewController(
        _ taskViewController: ORKTaskViewController,
        didFinishWith reason: ORKTaskViewControllerFinishReason,
        error: Error?) {

        taskViewController.dismiss(animated: true, completion: nil)
    }

}

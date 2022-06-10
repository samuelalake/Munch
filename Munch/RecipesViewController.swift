//
//  RecipesViewController.swift
//  Munch-RKCK
//
//  Created by Samuel Alake on 4/2/22.
//

import SwiftUI
import CareKit
import CareKitUI
import ResearchKit

class RecipesViewController: OCKListViewController, OCKFeaturedContentViewDelegate/*, ORKTaskViewControllerDelegate*/ {
    
    let storeManager: OCKSynchronizedStoreManager

    init(storeManager: OCKSynchronizedStoreManager) {
        self.storeManager = storeManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapView(_ view: OCKFeaturedContentView) {
        
        let detailViewController = Surveys.recipeDetailView()
        
        present(detailViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let kneeModelView = OCKFeaturedContentView(imageOverlayStyle: .dark)
        kneeModelView.delegate = self
        kneeModelView.label.text = "Wonton Noodle Stir-fry"
        kneeModelView.label.textColor = .systemBackground
        kneeModelView.imageView.image = UIImage(named: "wonton")
        appendView(kneeModelView, animated: true)
        
    }
    
    // MARK: ORKTaskViewControllerDelegate
//
//    func taskViewController(
//        _ taskViewController: ORKTaskViewController,
//        didFinishWith reason: ORKTaskViewControllerFinishReason,
//        error: Error?) {
//
//        taskViewController.dismiss(animated: true, completion: nil)
//    }

}

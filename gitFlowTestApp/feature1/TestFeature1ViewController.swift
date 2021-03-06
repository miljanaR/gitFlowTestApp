//
//  TestFeature1ViewController.swift
//  gitFlowTestApp
//
//  Created by Miljana Ratkov on 24/12/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TestFeature1DisplayLogic: class
{
  func displaySomething(viewModel: TestFeature1.Something.ViewModel)
}

class TestFeature1ViewController: UIViewController, TestFeature1DisplayLogic
{
  var interactor: TestFeature1BusinessLogic?
  var router: (NSObjectProtocol & TestFeature1RoutingLogic & TestFeature1DataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = TestFeature1Interactor()
    let presenter = TestFeature1Presenter()
    let router = TestFeature1Router()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = TestFeature1.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: TestFeature1.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}

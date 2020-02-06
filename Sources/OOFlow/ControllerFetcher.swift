

import UIKit

/// Returns a view controller configurated with the view model that is passed
/// - Parameter viewModel: The View Model used to configure the View Controller
///
/// - Note: This View Controller won't have any navigation responsabilities
///
/// - SeeAlso: 'getViewControllerToCurrentFlowConfigured', 'getNewFlowViewControllerConfigured'
internal func getViewControllerConfigured<VM: Configurer>(with viewModel: VM) -> VM.VC {
  let viewControoler = viewModel.managedController
  return viewControoler
}

/// Returns a view controller configurated with the view model that is passed to handle the current navigation
/// - Parameter viewModel: The View Model used to configure the View Controller
/// - Parameter flow: The Flow that will handle the navigation of the View Controller
/// - Note: The ViewModel will be able to trigger any kind of navigation in the current flow. It wont generate new flow
///
/// - SeeAlso: 'getViewControllerConfigured', 'getNewFlowViewControllerConfigured'
internal func getViewControllerToCurrentFlowConfigured<FM: StackFlowManager>(with viewModel: FM, and flow: FM.F?) -> FM.VC {
  var copyVM = viewModel
  copyVM.flow = flow
  let viewController = copyVM.managedController
  return viewController
}

///Returns a new navigation with the corresponding View Controller as root, configured with the viewModel passed
/// - Parameter viewModel: The View Model used to configure the View Controller
///
/// - Note: This method will generate a new flow in the view, without affecting the rest of the navigation flow in the application
///
/// - SeeAlso: 'getViewControllerConfigured', 'getViewControllerToCurrentFlowConfigured', 'getNewFlowViewControllerConfigured'
internal func getNewFlowViewControllerConfigured<FM: StackFlowManager>(with viewModel: FM) -> UINavigationController {
  let flow = StackFlowCoordinator<FM, FM.VC>(with: viewModel)
  flow.start()
  let navController = flow.navigationController!
  return navController
}

/// Returns the Navigation Controller with the corresponding View Controller as root from the flow passed
/// - Parameter flow: The View Model used to configure the View Controller
///
/// - Note: This method will generate a new flow in the view, without affecting the rest of the navigation flow in the application
///
/// - SeeAlso: 'getViewControllerConfigured', 'getViewControllerToCurrentFlowConfigured', 'getNewFlowViewControllerConfigured'
internal func getNewFlowViewControllerConfigured(with flow: StackFlow, hiddenNavController hide: Bool = true) -> UINavigationController {
  flow.start()
  let navController = flow.navigationController!
  navController.configureNavigationBar(asHidden: hide)
  return navController
}

//MARK: - Tab Bar Related

/// Returns the tab bar controller configured with the view view model associated to the tab bar
/// - Parameter viewModel: The View Model that will configure the Tab Bar Controller to present with the corresponding data
/// - Parameter flow: The flow that controls the logic of the Tab Bar
private func getTheTabBar(with viewModel: TabBarViewModel, and flow: Flow?) -> UITabBarController {
  let flows = viewModel.sections.map(TabFlowProvider.getTabFlow)
  
  let tabBarController = viewModel.managedController
  tabBarController.viewModel.flow = flow
  tabBarController.viewControllers = flows.compactMap {
    $0.navigationController
  }
  return tabBarController
}

/// Returns the corresponding sections when passing the data
/// - Parameter data: The data that contains the information about the sections
private func sections<T: Decodable>(from data: Data) -> [Section<T>]? {
  let decoder = JSONDecoder()
  do {
    let sections = try decoder.decode([Section<T>].self, from: data)
    return sections
  } catch {
    print("Error: \(error.localizedDescription)")
  }
  return nil
}

/// Returns the TabBar Controller created with the data
/// - Parameter type: The type that describes the possible Controllers that could be added to the tab bar
/// - Parameter data: The data that contains the information about the presented Sections
/// - Parameter flow: The flow that will present the Tab bar
///
/// - Note: The Flow passed is not the Tab Bar Flow, but the one that presents it on scene
public func getTheTabBar<T: TabbedController>(_ type: T.Type, from data: Data, and flow: Flow?) -> UITabBarController {
  guard let sections: [Section<T>] = sections(from: data) else { fatalError("") }
  let viewModel = TabBarViewModel(with: sections)
  return getTheTabBar(with: viewModel, and: flow)
}


import Foundation

internal struct TabBarViewModel: FlowManager {
  
  typealias VC = TabBarController
  
  var sections: [Tab]
  var flow: Flow!
  
  var managedController: TabBarController {
    return TabBarController.getConfiguredInstance(with: self)
  }
  
  init(with sections: [Tab]) {
    self.sections = sections
  }
}

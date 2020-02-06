
import UIKit

/// This protocol will be conformed by the View Models, that will mange the navigation of the scene
public protocol FlowManager: Configurer where VC: Managed {
  associatedtype F
  var flow: F! { get set }
  
  associatedtype VC
  var managedController: VC { get }
}

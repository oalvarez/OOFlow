
import Foundation

public protocol Tab: Decodable {
  var type: TabbedController { get }
  var title: String { get }
  var selectedImage: String { get }
  var unselectedImage: String { get }
}

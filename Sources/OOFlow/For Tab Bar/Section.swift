

import Foundation

/// A Section provides the data of the Tab in a Tab Bar
///
/// - Note: In order to implement Sections, you have to create an enum conforming to TabbedController, with the cases of the Scenes that will be presented as Tabs in each section
///
/// - SeeAlso: 'TabbedController'
public struct Section<T: TabbedController>: Tab {
  public var type: TabbedController
  public var title: String
  public var selectedImage: String
  public var unselectedImage: String

  public enum CodingKeys : String, CodingKey {
    case type
    case title
    case selectedImage
    case unselectedImage
  }
}

public extension Section {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    type = try! container.decode(T.self, forKey: .type)
    title = try! container.decode(String.self, forKey: .title)
    selectedImage = try! container.decode(String.self, forKey: .selectedImage)
    unselectedImage = try! container.decode(String.self, forKey: .unselectedImage)
  }
}

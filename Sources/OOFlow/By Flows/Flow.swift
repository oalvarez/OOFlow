
import UIKit

public protocol Flow {
  func start()
  func stop()
}

public extension Flow {
  func stop() { }
}

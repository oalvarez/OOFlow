
import Foundation

public extension Data {
  /// Returns the data from a JSON file in the Bundle
  /// - Parameter file: Name of the file where the data is placed
  /// - Parameter bundle: Budle where the data is placed
  static func from(fileNamed file: String, at bundle: Bundle) -> Data? {
    guard let json = bundle.path(forResource: file, ofType: "json"),
      let data =  FileManager.default.contents(atPath: json) else { return nil }
    return data
  }
}

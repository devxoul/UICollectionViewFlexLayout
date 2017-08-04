// swift-tools-version:3.1

import Foundation
import PackageDescription

var dependencies: [Package.Dependency] = []

let isTest = ProcessInfo.processInfo.environment["TEST"] == "1"
if isTest {
  dependencies.append(
    .Package(url: "https://github.com/devxoul/Stubber.git", majorVersion: 0)
  )
}

let package = Package(
  name: "UICollectionViewFlexLayout",
  dependencies: dependencies
)

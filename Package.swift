// swift-tools-version:5.0

import PackageDescription

let package = Package(
  name: "UICollectionViewFlexLayout",
  platforms: [
    .iOS(.v8)
  ],
  products: [
    .library(name: "UICollectionViewFlexLayout", targets: ["UICollectionViewFlexLayout"]),
  ],
  dependencies: [
    .package(url: "https://github.com/devxoul/Stubber.git", .upToNextMajor(from: "1.0.0"))
  ],
  targets: [
    .target(name: "UICollectionViewFlexLayout"),
    .testTarget(name: "UICollectionViewFlexLayoutTests", dependencies: ["UICollectionViewFlexLayout", "Stubber"]),
  ],
  swiftLanguageVersions: [.v5]
)

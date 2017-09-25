// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "UICollectionViewFlexLayout",
  products: [
    .library(name: "UICollectionViewFlexLayout", targets: ["UICollectionViewFlexLayout"]),
  ],
  dependencies: [
    .package(url: "https://github.com/devxoul/Stubber.git", .upToNextMajor(from: "1.0.0"))
  ],
  targets: [
    .target(name: "UICollectionViewFlexLayout"),
    .testTarget(name: "UICollectionViewFlexLayoutTests", dependencies: ["UICollectionViewFlexLayout", "Stubber"]),
  ]
)

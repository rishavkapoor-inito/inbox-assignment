// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
  name: "InboxKit",
  platforms: [.iOS(.v15)],
  products: [.library(name: "InboxKit", targets: ["InboxKit"])],
  dependencies: [
    .package(path: "../InboxNetworking"),
    .package(path: "../InboxResources")
  ],
  targets: [
    .target(
      name: "InboxKit",
      dependencies: ["InboxNetworking", "InboxResources"],
      resources: [.process("Sources/InboxKit/InboxModel.xcdatamodeld")]
    ),
    .testTarget(
      name: "InboxKitTests",
      dependencies: ["InboxKit", "InboxNetworking", "InboxResources"]
    )
  ]
)

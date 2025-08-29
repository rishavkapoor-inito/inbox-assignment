// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "InboxNetworking",
  platforms: [.iOS(.v15)],
  products: [.library(name: "InboxNetworking", targets: ["InboxNetworking"])],
  dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.0"),
    .package(path: "../InboxResources")
  ],
  targets: [
    .target(
      name: "InboxNetworking",
      dependencies: [
        .product(name: "Alamofire", package: "Alamofire"),
        "InboxResources"
      ],
      resources: []
    ),
    .testTarget(
      name: "InboxNetworkingTests",
      dependencies: ["InboxNetworking", "InboxResources"]
    )
  ]
)

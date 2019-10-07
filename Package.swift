// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Relayer",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .executable(
            name: "relayer",
            targets: ["relayer"]
        ),
        .library(
            name: "RelayerFramework",
            targets: ["RelayerFramework"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/ultralight-beam/UB.swift.git", from: "0.2.0"),
        // .package(path: "../UB.swift/"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "relayer",
            dependencies: ["RelayerFramework"]
        ),
        .target(
            name: "RelayerFramework",
            dependencies: ["UB"]
        ),
        .testTarget(
            name: "RelayerFrameworkTests",
            dependencies: ["RelayerFramework"]
        ),
    ]
)

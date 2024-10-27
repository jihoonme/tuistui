// swift-tools-version: 6.0
@preconcurrency import PackageDescription

let package = Package(
    name: "tuistui",
    platforms: [.macOS(.v13)],
    products: [
        .executable(
            name: "tuist-ui",
            targets: ["TuistUICLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.3"),
        .package(url: "https://github.com/tuist/tuist", from: "4.31.0"),
    ],
    targets: [
        .executableTarget(name: "TuistUICLI"),
        .target(
            name: "TuistUI",
            dependencies: [
                 .product(name: "ProjectDescription", package: "tuist"),
            ],
            path: "ProjectDescriptionHelpers"
        ),
        .testTarget(
            name: "TuistUITests",
            dependencies: [
                "TuistUI"
            ],
            path: "Tests"
        ),
    ]
)

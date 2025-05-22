// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "UejoAppPages",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "UejoAppPages",
            targets: ["UejoAppPages"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "UejoAppPages",
            dependencies: ["Publish"]
        )
    ]
)

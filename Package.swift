// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "OYExtensions",
    products: [
        .library(name: "OYExtensions", targets: ["OYExtensions"])
    ],
    targets: [
        .target(name: "OYExtensions", path: "Sources")
    ]
)

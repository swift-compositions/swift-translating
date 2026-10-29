// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-translating",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Translating", targets: ["Translating"]),
        .library(name: "Language", targets: ["Language"]),
        .library(name: "Single Plural", targets: ["Single Plural"]),
        .library(name: "Translated", targets: ["Translated"]),
        .library(name: "Translated String", targets: ["Translated String"]),
        .library(name: "Translating Platform", targets: ["Translating Platform"]),
        .library(name: "Translating Test Support", targets: ["Translating Test Support"]),
        .library(name: "Translations", targets: ["Translations"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-ietf/swift-bcp-47.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-639.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-3166.git", branch: "main"),
        .package(
            url: "https://github.com/swift-compositions/swift-dependencies.git",
            branch: "main"
        ),
    ],
    traits: [
        .trait(
            name: "TranslatingPlatform",
            description: "Translating Platform and the dependencies only it needs"
        )
    ],
    targets: [

        .target(
            name: "Translating",
            dependencies: [
                .target(name: "Language"),
                .target(name: "Single Plural"),
                .target(name: "Translated"),
                .target(name: "Translated String"),
            ]
        ),

        .target(
            name: "Language",
            dependencies: [
                .product(name: "BCP 47", package: "swift-bcp-47"),
                .product(name: "ISO 639", package: "swift-iso-639"),
                .product(name: "ISO 3166", package: "swift-iso-3166"),
            ]
        ),
        .testTarget(
            name: "Language Tests",
            dependencies: [
                .target(name: "Language"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),

        .target(
            name: "Single Plural",
            dependencies: [
                .target(name: "Language"),
                .target(name: "Translated"),
                .target(name: "Translated String"),
            ]
        ),
        .testTarget(
            name: "Single Plural Tests",
            dependencies: [
                .target(name: "Single Plural"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),

        .target(
            name: "Translated",
            dependencies: [
                .target(name: "Language")
            ]
        ),
        .testTarget(
            name: "Translated Tests",
            dependencies: [
                .target(name: "Translated"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),

        .target(
            name: "Translated String",
            dependencies: [
                .target(name: "Translated")
            ]
        ),
        .testTarget(
            name: "Translated String Tests",
            dependencies: [
                .target(name: "Translated String"),
                .target(name: "Translating Platform"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),

        .target(
            name: "Translating Platform",
            dependencies: [
                .product(
                    name: "Dependencies",
                    package: "swift-dependencies",
                    condition: .when(traits: ["TranslatingPlatform"])
                ),
                .target(name: "Language"),
                .target(name: "Single Plural"),
                .target(name: "Translated"),
                .target(name: "Translated String"),
                .target(name: "Translating"),
            ]
        ),
        .testTarget(
            name: "Translating Platform Tests",
            dependencies: [
                .target(name: "Translating Platform"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
                .target(name: "Language"),
            ]
        ),

        .target(name: "Translating Test Support"),

        .target(
            name: "Translations",
            dependencies: [
                .target(name: "Translating")
            ]
        ),
        .testTarget(
            name: "Translations Tests",
            dependencies: [
                .target(name: "Translations"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

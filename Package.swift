// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "GPayByRazorpayKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "GPayByRazorpayKit", targets: ["GPayByRazorpayKit"])
    ],
    dependencies: [
        // Official Razorpay SPM (has releases and SPM support)
        .package(url: "https://github.com/razorpay/razorpay-pod.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "GPayByRazorpayKit",
            dependencies: [
                .product(name: "RazorpayCheckout", package: "razorpay-pod")
            ]
        ),
        .testTarget(
            name: "GPayByRazorpayKitTests",
            dependencies: ["GPayByRazorpayKit"]
        )
    ]
)

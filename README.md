[![Cocoapods](https://img.shields.io/cocoapods/v/OYExtensions.svg)](https://cocoapods.org/pods/OYExtensions)
[![SPM compatible](https://img.shields.io/badge/SPM-Compatible-red.svg?style=flat)](https://swift.org/package-manager/)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20watchOS-yellow.svg)](https://github.com/osmanyildirim/OYExtensions)
[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-14.2-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-lightgray.svg)](https://opensource.org/licenses/MIT)

<p align="left">
  <img src="Assets/Banner.png" title="OYExtensions">
</p>

Some useful extension for Swift

## Contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Extensions](#extensions)
* [License](#license)

## Requirements

* iOS 11.0+, tvOS 11.0+, watchOS 6.0+
* Swift 5.0+

## Installation

<details>
<summary>CocoaPods</summary>
<br/>
<p>Add the following line to your <code>Podfile</code></p>

```
pod 'OYExtensions'
```

</details>

<details>
  <summary>Swift Package Manager</summary>
  <br/>
Add OYExtensions as a dependency to your <code>Package.swift</code> and specify OYExtensions as a target dependency:
  <br/>

```swift
import PackageDescription
  
let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/osmanyildirim/OYExtensions.git", .upToNextMinor(from: "1.0")),
    ],
    targets: [
        .target(
            name: "YOUR_PROJECT_NAME",
            dependencies: ["OYExtensions"])
    ]
)

```

</details>

## Extensions

<details>
<summary>Combine Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Combine/Publisher%2BExtensions.swift"><code>Publisher extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreGraphics Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreGraphics/CGFloat%2BExtensions.swift"><code>CGFloat extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreGraphics/CGPoint%2BExtensions.swift"><code>CGPoint extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreGraphics/CGRect%2BExtensions.swift"><code>CGRect extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreGraphics/CGSize%2BExtensions.swift"><code>CGSize extensions</code></a></li>
</ul>
</details>

<details>
<summary>CoreLocation Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreLocation/CLLocation%2BExtensions.swift"><code>CLLocation extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreLocation/CLLocationCoordinate2D%2BExtensions.swift"><code>CLLocationCoordinate2D extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreLocation/MKMapItem%2BExtensions.swift"><code>MKMapItem extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreLocation/MKMapView%2BExtensions.swift"><code>MKMapView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/CoreLocation/MKPolyline%2BExtensions.swift"><code>MKPolyline extensions</code></a></li>
</ul>
</details>

<details>
<summary>Foundation Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/AttributedString%2BExtensions.swift"><code>AttributedString extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Bundle%2BExtensions.swift"><code>Bundle extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Data%2BExtensions.swift"><code>Data extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Date%2BExtensions.swift"><code>Date extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Decodable%2BExtensions.swift"><code>Decodable extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/DispatchQueue%2BExtensions.swift"><code>DispatchQueue extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Encodable%2BExtensions.swift"><code>Encodable extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/FileManager%2BExtensions.swift"><code>FileManager extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Measurement%2BExtensions.swift"><code>Measurement extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/NSObject%2BExtensions.swift"><code>NSObject extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/NSString%2BExtensions.swift"><code>NSString extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/Timer%2BExtensions.swift"><code>Timer extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/URL%2BExtensions.swift"><code>URL extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Foundation/UserDefaults%2BExtensions.swift"><code>UserDefaults extensions</code></a></li>
</ul>
</details>

<details>
<summary>SwiftStdlib Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Array%2BExtensions.swift"><code>Array extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Bool%2BExtensions.swift"><code>Bool extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Character%2BExtensions.swift"><code>Character extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Comparable%2BExtensions.swift"><code>Comparable extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Dictionary%2BExtensions.swift"><code>Dictionary extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Double%2BExtensions.swift"><code>Double extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Float%2BExtensions.swift"><code>Float extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Int%2BExtensions.swift"><code>Int extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/Optional%2BExtensions.swift"><code>Optional extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/SwiftStdlib/String%2BExtensions.swift"><code>String extensions</code></a></li>
</ul>
</details>

<details>
<summary>UIGestureRecognizer Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Gesture/OYLongPressGesture.swift"><code>LongPressGesture extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Gesture/OYPanGesture.swift"><code>PanGesture extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Gesture/OYPinchGesture.swift"><code>PinchGesture extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Gesture/OYSwipeGesture.swift"><code>SwipeGesture extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Gesture/OYTapGesture.swift"><code>Tap extensions</code></a></li>
</ul>
</details>

<details>
<summary>UIKit Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/NSLayoutConstraint%2BExtensions.swift"><code>NSLayoutConstraint extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIAlertController%2BExtensions.swift"><code>UIAlertController extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIApplication%2BExtensions.swift"><code>UIApplication extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIButton%2BExtensions.swift"><code>UIButton extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UICollectionView%2BExtensions.swift"><code>UICollectionView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIColor%2BExtensions.swift"><code>UIColor extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIControl%2BExtensions.swift"><code>UIControl extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIDatePicker%2BExtensions.swift"><code>UIDatePicker extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIDevice%2BExtensions.swift"><code>UIDevice extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIFeedbackGenerator%2BExtensions.swift"><code>UIFeedbackGenerator extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIFont%2BExtensions.swift"><code>UIFont extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIImage%2BExtensions.swift"><code>UIImage extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIImageView%2BExtensions.swift"><code>UIImageView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UILabel%2BExtensions.swift"><code>UILabel extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UINavigationBar%2BExtensions.swift"><code>UINavigationBar extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UINavigationController%2BExtensions.swift"><code>UINavigationController extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIPasteboard%2BExtensions.swift"><code>UIPasteboard extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIPickerView%2BExtensions.swift"><code>UIPickerView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIRefreshControl%2BExtensions.swift"><code>UIRefreshControl extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIScreen%2BExtensions.swift"><code>UIScreen extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIScrollView%2BExtensions.swift"><code>UIScrollView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UISearchBar%2BExtensions.swift"><code>UISearchBar extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UISlider%2BExtensions.swift"><code>UISlider extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIStackView%2BExtensions.swift"><code>UIStackView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UISegmentedControl%2BExtensions.swift"><code>UISegmentedControl extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UISwitch%2BExtensions.swift"><code>UISwitch extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITabBar%2BExtensions.swift"><code>UITabBar extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITabBarController%2BExtensions.swift"><code>UITabBarController extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITabBarItem%2BExtensions.swift"><code>UITabBarItem extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITableView%2BExtensions.swift"><code>UITableView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITextField%2BExtensions.swift"><code>UITextField extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UITextView%2BExtensions.swift"><code>UITextView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIUserInterfaceSizeClass%2BExtensions.swift"><code>UIUserInterfaceSizeClass extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIView%2BExtensions.swift"><code>UIView extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIViewController%2BExtensions.swift"><code>UIViewController extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UIWindow%2BExtensions.swift"><code>UIWindow extensions</code></a></li>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/UIKit/UInt%2BExtensions.swift"><code>UInt extensions</code></a></li>
</ul>
</details>

<details>
<summary>WebKit Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/WebKit/WKWebView%2BExtensions.swift"><code>WKWebView extensions</code></a></li>
</ul>
</details>

<details>
<summary>Other Extensions</summary>
<ul>
<li><a href="https://github.com/osmanyildirim/OYExtensions/blob/main/Sources/Other/OYHandlerButton.swift"><code>Handler button</code></a></li>
</ul>
</details>

## License
OYExtensions is released under an MIT license. [See LICENSE](https://github.com/osmanyildirim/OYExtensions/blob/main/LICENSE) for details.
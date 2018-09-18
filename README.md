# UICollectionViewFlexLayout

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/UICollectionViewFlexLayout.svg)](https://cocoapods.org/pods/UICollectionViewFlexLayout)
[![Build Status](https://travis-ci.org/devxoul/UICollectionViewFlexLayout.svg?branch=master)](https://travis-ci.org/devxoul/UICollectionViewFlexLayout)
[![Codecov](https://img.shields.io/codecov/c/github/devxoul/UICollectionViewFlexLayout.svg)](https://codecov.io/gh/devxoul/UICollectionViewFlexLayout)

UICollectionViewFlexLayout is a drop-in replacement for UICollectionViewFlowLayout.

## Features

* [x] Section Spacing
* [x] Section Margin
* [x] Section Padding
* [x] Section Background
* [x] Item Spacing
* [x] Item Margin
* [x] Item Padding
* [x] Item Size
* [x] Item Background
* [x] Item Z-Index

## Basic Concept

Don't let cells have margins and paddings. Cell metrics are now set outside of the cell. Just focus on contents.

![idea](https://user-images.githubusercontent.com/931655/28981116-59c51f24-798b-11e7-8877-b4e7f83644d1.jpg)

## Usage

### UICollectionViewDelegateFlexLayout

```swift
protocol UICollectionViewDelegateFlexLayout {
  // section vertical spacing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenSectionAt section: Int, and nextSection: Int) -> CGFloat

  // section margin
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForSectionAt section: Int) -> UIEdgeInsets

  // section padding
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForSectionAt section: Int) -> UIEdgeInsets

  // item horizontal spacing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, horizontalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat

  // item vertical spacing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat

  // item margin
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForItemAt indexPath: IndexPath) -> UIEdgeInsets

  // item padding
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForItemAt indexPath: IndexPath) -> UIEdgeInsets

  // item size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, sizeForItemAt indexPath: IndexPath) -> CGSize

  // item z-index
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, zIndexForItemAt indexPath: IndexPath) -> Int
}
```

### Section and Item Background

```swift
// register
collectionView.register(MySectionBackgroundView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionBackground, withReuseIdentifier: "mySectionBackgroundView")
collectionView.register(MyItemBackgroundView.self, forSupplementaryViewOfKind: UICollectionElementKindItemBackground, withReuseIdentifier: "myItemBackgroundView")

// configure
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
  switch kind {
  case UICollectionElementKindSectionBackground: // section background
    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionBackground, withReuseIdentifier: "mySectionBackgroundView", for: indexPath)

  case UICollectionElementKindItemBackground: // item background
    return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindItemBackground, withReuseIdentifier: "myItemBackgroundView", for: indexPath)

  case foo: // else
    return bar
  }
}
```

## Tips and Tricks

* **Using with RxCocoa**

    If you're using UICollectionView with RxSwift and RxCocoa, you should create an extension of `_RXDelegateProxy` class to support delegate proxy.

    ```swift
    import RxCocoa
    import UICollectionViewFlexLayout

    extension _RXDelegateProxy: UICollectionViewDelegateFlexLayout {
    }
    ```

## Contributing

```console
$ swift package generate-xcodeproj
```

## License

UICollectionViewFlexLayout is under MIT license. See the [LICENSE](LICENSE) file for more info.

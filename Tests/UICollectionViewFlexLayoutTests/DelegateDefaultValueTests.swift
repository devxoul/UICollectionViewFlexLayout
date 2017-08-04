#if os(iOS)
import XCTest
@testable import UICollectionViewFlexLayout

final class DelegateDefaultValueTests: TestCase, UICollectionViewDelegateFlexLayout {
  func testItemSize() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.size(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }

  func testSectionVerticalSpacing() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.verticalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testSectionMargin() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.margin(forSectionAt: 0), .zero)
  }

  func testSectionPadding() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.padding(forSectionAt: 0), .zero)
  }

  func testItemHorizontalSpacing() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.horizontalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testItemVerticalSpacing() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.verticalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testItemMargin() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.margin(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }

  func testItemPadding() {
    let frame = UIScreen.main.bounds
    let layout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    collectionView.delegate = self
    layout.invalidateLayout()
    XCTAssertEqual(layout.padding(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }
}
#endif

#if os(iOS)
import XCTest
@testable import UICollectionViewFlexLayout

final class DelegateDefaultValueTests: TestCase, UICollectionViewDelegateFlexLayout {
  fileprivate var flexLayout: UICollectionViewFlexLayout!

  override func setUp() {
    super.setUp()
    let frame = UIScreen.main.bounds
    self.flexLayout = UICollectionViewFlexLayout()
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: self.flexLayout)
    collectionView.delegate = self
    self.flexLayout.invalidateLayout()
  }

  func testItemSize() {
    XCTAssertEqual(self.flexLayout.size(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }

  func testSectionVerticalSpacing() {
    XCTAssertEqual(self.flexLayout.verticalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testSectionMargin() {
    XCTAssertEqual(self.flexLayout.margin(forSectionAt: 0), .zero)
  }

  func testSectionPadding() {
    XCTAssertEqual(self.flexLayout.padding(forSectionAt: 0), .zero)
  }

  func testItemHorizontalSpacing() {
    XCTAssertEqual(self.flexLayout.horizontalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testItemVerticalSpacing() {
    XCTAssertEqual(self.flexLayout.verticalSpacing(betweenItemAt: IndexPath(item: 0, section: 0), and: IndexPath(item: 1, section: 0)), 0)
  }

  func testItemMargin() {
    XCTAssertEqual(self.flexLayout.margin(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }

  func testItemPadding() {
    XCTAssertEqual(self.flexLayout.padding(forItemAt: IndexPath(item: 0, section: 0)), .zero)
  }

  func testItemZIndex() {
    XCTAssertEqual(self.flexLayout.zIndex(forItemAt: IndexPath(item: 0, section: 0)), 0)
  }
}
#endif

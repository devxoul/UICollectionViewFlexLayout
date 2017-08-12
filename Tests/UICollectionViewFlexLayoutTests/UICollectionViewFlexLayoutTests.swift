#if os(iOS)
import XCTest
import UICollectionViewFlexLayout

private struct BasicSection: SectionModelType {
  var items: [BasicSectionItem]
}

private struct BasicSectionItem {
}

final class UICollectionViewFlexLayoutTests: TestCase {
  func testItemSizeOnly() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 50, height: 30)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 150))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 0,  y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 50, y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 0,  y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 50, y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 0,  y: 60,  width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 0,  y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 50, y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 0,  y: 120, width: 50, height: 30))
  }

  func testItemSizeOnly_differentHeight() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _, _, indexPath in
      if indexPath.item % 2 == 0 {
        return CGSize(width: 40, height: 30 * (1 + indexPath.item))
      } else {
        return CGSize(width: 40, height: 10 * (1 + indexPath.item))
      }
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 390))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 0,  y: 0,   width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 40, y: 0,   width: 40, height: 20))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 0,  y: 30,  width: 40, height: 90))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 40, y: 30,  width: 40, height: 40))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 0,  y: 120, width: 40, height: 150))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 0,  y: 270, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 40, y: 270, width: 40, height: 20))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 0,  y: 300, width: 40, height: 90))
  }

  func testSectionPaddingMargin() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 40, height: 30)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 182))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 8,  y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 48, y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 8,  y: 36, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 48, y: 36, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 8,  y: 66, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 8,  y: 112, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 48, y: 112, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 8,  y: 142, width: 40, height: 30))
  }

  func testSectionPaddingMarginSpacing() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 40, height: 30)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:verticalSpacingBetweenSectionAt:and:)) { _ in
      return 20
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
      BasicSection(items: .init(repeating: .init(), count: 2)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 268))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 8,  y: 132, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 48, y: 132, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 8,  y: 162, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 2, 0), CGRect(x: 8,  y: 228, width: 40, height: 30))
    XCTAssertEqual(self.frame(at: 2, 1), CGRect(x: 48, y: 228, width: 40, height: 30))
  }

  func testItemPaddingMargin() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 30, height: 40)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 280))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 8,  y: 6,   width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 58, y: 6,   width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 8,  y: 62,  width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 58, y: 62,  width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 8,  y: 118, width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 8,  y: 174, width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 58, y: 174, width: 30, height: 40))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 8,  y: 230, width: 30, height: 40))
  }

  func testItemPaddingMarginSpacing() {
    self.collectionView.frame.size.width = 100
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 15, height: 40)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:horizontalSpacingBetweenItemAt:and:)) { _ in
      return 10
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:verticalSpacingBetweenItemAt:and:)) { _ in
      return 20
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 340))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 8,  y: 6,   width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 53, y: 6,   width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 8,  y: 82,  width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 53, y: 82,  width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 8,  y: 158, width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 8,  y: 214, width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 53, y: 214, width: 15, height: 40))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 8,  y: 290, width: 15, height: 40))
  }

  func testEverything() {
    self.collectionView.frame.size.width = 400
    self.delegate.stub(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 60, height: 40)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:verticalSpacingBetweenSectionAt:and:)) { _ in
      return 10
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 9, left: 10, bottom: 11, right: 12)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 13, left: 14, bottom: 15, right: 16)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:horizontalSpacingBetweenItemAt:and:)) { _ in
      return 20
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:verticalSpacingBetweenItemAt:and:)) { _ in
      return 30
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 400, height: 336))
    XCTAssertEqual(self.frame(at: 0, 0), CGRect(x: 32,  y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 0, 1), CGRect(x: 164, y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 0, 2), CGRect(x: 296, y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 0, 3), CGRect(x: 32,  y: 146, width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 0, 4), CGRect(x: 164, y: 146, width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 1, 0), CGRect(x: 32,  y: 260, width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 1, 1), CGRect(x: 164, y: 260, width: 60, height: 40))
    XCTAssertEqual(self.frame(at: 1, 2), CGRect(x: 296, y: 260, width: 60, height: 40))
  }

  func testMaximumWidth() {
    self.collectionView.frame.size.width = 375
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 9, left: 10, bottom: 11, right: 12)
    }
    self.delegate.stub(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 13, left: 14, bottom: 15, right: 16)
    }
    XCTAssertEqual(self.layout.maximumWidth(forItemAt: IndexPath(item: 0, section: 0)), 303)
  }
}
#endif

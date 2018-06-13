#if os(iOS)
import XCTest
import Stubber
import UICollectionViewFlexLayout

private struct BasicSection: SectionModelType {
  var items: [BasicSectionItem]
}

private struct BasicSectionItem {
}

final class UICollectionViewFlexLayoutTests: TestCase {
  func testItemSizeOnly() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 50, height: 30)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 150))
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 0,  y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 50, y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 0,  y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 50, y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 0,  y: 60,  width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 0,  y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 50, y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 0,  y: 120, width: 50, height: 30))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 0, y: 0,  width: 100, height: 90))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 0, y: 90, width: 100, height: 60))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 0,  y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 50, y: 0,   width: 50, height: 30))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 0,  y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 50, y: 30,  width: 50, height: 30))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 0,  y: 60,  width: 50, height: 30))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 0,  y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 50, y: 90,  width: 50, height: 30))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 0,  y: 120, width: 50, height: 30))
  }

  func testItemSizeOnly_differentHeight() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _, _, indexPath in
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
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 0,  y: 0,   width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 40, y: 0,   width: 40, height: 20))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 0,  y: 30,  width: 40, height: 90))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 40, y: 30,  width: 40, height: 40))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 0,  y: 120, width: 40, height: 150))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 0,  y: 270, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 40, y: 270, width: 40, height: 20))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 0,  y: 300, width: 40, height: 90))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 0, y: 0,   width: 100, height: 270))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 0, y: 270, width: 100, height: 120))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 0,  y: 0,   width: 40, height: 30))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 40, y: 0,   width: 40, height: 20))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 0,  y: 30,  width: 40, height: 90))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 40, y: 30,  width: 40, height: 40))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 0,  y: 120, width: 40, height: 150))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 0,  y: 270, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 40, y: 270, width: 40, height: 20))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 0,  y: 300, width: 40, height: 90))
  }

  func testSectionPaddingMargin() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 40, height: 30)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 182))
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 8,  y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 48, y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 8,  y: 36, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 48, y: 36, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 8,  y: 66, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 8,  y: 112, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 48, y: 112, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 8,  y: 142, width: 40, height: 30))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 2, y: 1,   width: 94, height: 102))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 2, y: 107, width: 94, height: 72))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 8,  y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 48, y: 6,  width: 40, height: 30))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 8,  y: 36, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 48, y: 36, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 8,  y: 66, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 8,  y: 112, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 48, y: 112, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 8,  y: 142, width: 40, height: 30))
  }

  func testSectionPaddingMarginSpacing() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 40, height: 30)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    Stubber.register(self.delegate.collectionView(_:layout:verticalSpacingBetweenSectionAt:and:)) { _ in
      return 20
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
      BasicSection(items: .init(repeating: .init(), count: 2)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 268))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 8,  y: 132, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 48, y: 132, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 8,  y: 162, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 2, 0)?.frame, CGRect(x: 8,  y: 228, width: 40, height: 30))
    XCTAssertEqual(self.cell(at: 2, 1)?.frame, CGRect(x: 48, y: 228, width: 40, height: 30))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 2, y: 1,   width: 94, height: 102))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 2, y: 127, width: 94, height: 72))
    XCTAssertEqual(self.background(at: 2)?.frame, CGRect(x: 2, y: 223, width: 94, height: 42))

    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 8,  y: 132, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 48, y: 132, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 8,  y: 162, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 2, 0)?.frame, CGRect(x: 8,  y: 228, width: 40, height: 30))
    XCTAssertEqual(self.background(at: 2, 1)?.frame, CGRect(x: 48, y: 228, width: 40, height: 30))
  }

  func testItemPaddingMargin() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 30, height: 40)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 280))
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 8,  y: 6,   width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 58, y: 6,   width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 8,  y: 62,  width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 58, y: 62,  width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 8,  y: 118, width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 8,  y: 174, width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 58, y: 174, width: 30, height: 40))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 8,  y: 230, width: 30, height: 40))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 0, y: 0,   width: 100, height: 168))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 0, y: 168, width: 100, height: 112))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 6,  y: 5,   width: 36, height: 44))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 56, y: 5,   width: 36, height: 44))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 6,  y: 61,  width: 36, height: 44))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 56, y: 61,  width: 36, height: 44))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 6,  y: 117, width: 36, height: 44))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 6,  y: 173, width: 36, height: 44))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 56, y: 173, width: 36, height: 44))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 6,  y: 229, width: 36, height: 44))
  }

  func testItemPaddingMarginSpacing() {
    self.collectionView.frame.size.width = 100
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 15, height: 40)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    Stubber.register(self.delegate.collectionView(_:layout:horizontalSpacingBetweenItemAt:and:)) { _ in
      return 10
    }
    Stubber.register(self.delegate.collectionView(_:layout:verticalSpacingBetweenItemAt:and:)) { _ in
      return 20
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 100, height: 340))
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 8,  y: 6,   width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 53, y: 6,   width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 8,  y: 82,  width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 53, y: 82,  width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 8,  y: 158, width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 8,  y: 214, width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 53, y: 214, width: 15, height: 40))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 8,  y: 290, width: 15, height: 40))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 0, y: 0,   width: 100, height: 208))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 0, y: 208, width: 100, height: 132))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 6,  y: 5,   width: 21, height: 44))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 51, y: 5,   width: 21, height: 44))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 6,  y: 81,  width: 21, height: 44))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 51, y: 81,  width: 21, height: 44))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 6,  y: 157, width: 21, height: 44))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 6,  y: 213, width: 21, height: 44))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 51, y: 213, width: 21, height: 44))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 6,  y: 289, width: 21, height: 44))
  }

  func testEverything() {
    self.collectionView.frame.size.width = 400
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 60, height: 40)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    Stubber.register(self.delegate.collectionView(_:layout:verticalSpacingBetweenSectionAt:and:)) { _ in
      return 10
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 9, left: 10, bottom: 11, right: 12)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 13, left: 14, bottom: 15, right: 16)
    }
    Stubber.register(self.delegate.collectionView(_:layout:horizontalSpacingBetweenItemAt:and:)) { _ in
      return 20
    }
    Stubber.register(self.delegate.collectionView(_:layout:verticalSpacingBetweenItemAt:and:)) { _ in
      return 30
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 5)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.collectionView.contentSize, CGSize(width: 400, height: 336))
    XCTAssertEqual(self.cell(at: 0, 0)?.frame, CGRect(x: 32,  y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 0, 1)?.frame, CGRect(x: 164, y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 0, 2)?.frame, CGRect(x: 296, y: 28,  width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 0, 3)?.frame, CGRect(x: 32,  y: 146, width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 0, 4)?.frame, CGRect(x: 164, y: 146, width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 1, 0)?.frame, CGRect(x: 32,  y: 260, width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 1, 1)?.frame, CGRect(x: 164, y: 260, width: 60, height: 40))
    XCTAssertEqual(self.cell(at: 1, 2)?.frame, CGRect(x: 296, y: 260, width: 60, height: 40))

    XCTAssertEqual(self.background(at: 0)?.frame, CGRect(x: 2, y: 1,   width: 394, height: 218))
    XCTAssertEqual(self.background(at: 1)?.frame, CGRect(x: 2, y: 233, width: 394, height: 100))
    XCTAssertEqual(self.background(at: 2), nil)

    XCTAssertEqual(self.background(at: 0, 0)?.frame, CGRect(x: 18,  y: 15,  width: 90, height: 68))
    XCTAssertEqual(self.background(at: 0, 1)?.frame, CGRect(x: 150, y: 15,  width: 90, height: 68))
    XCTAssertEqual(self.background(at: 0, 2)?.frame, CGRect(x: 282, y: 15,  width: 90, height: 68))
    XCTAssertEqual(self.background(at: 0, 3)?.frame, CGRect(x: 18,  y: 133, width: 90, height: 68))
    XCTAssertEqual(self.background(at: 0, 4)?.frame, CGRect(x: 150, y: 133, width: 90, height: 68))
    XCTAssertEqual(self.background(at: 1, 0)?.frame, CGRect(x: 18,  y: 247, width: 90, height: 68))
    XCTAssertEqual(self.background(at: 1, 1)?.frame, CGRect(x: 150, y: 247, width: 90, height: 68))
    XCTAssertEqual(self.background(at: 1, 2)?.frame, CGRect(x: 282, y: 247, width: 90, height: 68))
  }

  func testZIndex() {
    Stubber.register(self.delegate.collectionView(_:layout:zIndexForItemAt:)) { _, _, indexPath in
      return indexPath.item * 2
    }
    self.dataSource(for: BasicSection.self).sections = [
      BasicSection(items: .init(repeating: .init(), count: 2)),
      BasicSection(items: .init(repeating: .init(), count: 3)),
    ]
    XCTAssertEqual(self.cell(at: 0, 0)?.zIndex, 0)
    XCTAssertEqual(self.cell(at: 0, 1)?.zIndex, 2)
    XCTAssertEqual(self.cell(at: 1, 0)?.zIndex, 0)
    XCTAssertEqual(self.cell(at: 1, 1)?.zIndex, 2)
    XCTAssertEqual(self.cell(at: 1, 2)?.zIndex, 4)
  }

  func testBackgroundZIndex() {
    Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
      return CGSize(width: 50, height: 50)
    }
    Stubber.register(self.delegate.collectionView(_:layout:zIndexForItemAt:)) { _, _, indexPath in
      return -1 * (10 * indexPath.section + indexPath.item)
    }

    let dataSource = self.dataSource(for: BasicSection.self)
    dataSource.sections = [
      BasicSection(items: .init(repeating: .init(), count: 3)),
      BasicSection(items: .init(repeating: .init(), count: 2)),
      BasicSection(items: .init(repeating: .init(), count: 5)),
    ]

    let minimumItemZIndex: Int = dataSource.sections.enumerated()
      .flatMap { sectionIndex, section in
        section.items.indices.compactMap { itemIndex in
          self.cell(at: sectionIndex, itemIndex)
        }
      }
      .map { $0.zIndex }
      .min() ?? 0
    XCTAssertEqual(minimumItemZIndex, -24)

    let minimumSectionZIndex: Int = dataSource.sections.indices
      .compactMap { self.background(at: $0)?.zIndex }
      .min() ?? 0
    XCTAssertLessThan(minimumSectionZIndex, minimumItemZIndex)

    XCTAssertLessThan(self.background(at: 0)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 1)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2)!.zIndex, minimumItemZIndex)

    XCTAssertLessThan(self.background(at: 0, 0)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 0, 1)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 0, 2)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 1, 0)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 1, 1)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2, 0)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2, 1)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2, 2)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2, 3)!.zIndex, minimumItemZIndex)
    XCTAssertLessThan(self.background(at: 2, 4)!.zIndex, minimumItemZIndex)

    XCTAssertGreaterThan(self.background(at: 0, 0)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 0, 1)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 0, 2)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 1, 0)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 1, 1)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 2, 0)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 2, 1)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 2, 2)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 2, 3)!.zIndex, minimumSectionZIndex)
    XCTAssertGreaterThan(self.background(at: 2, 4)!.zIndex, minimumSectionZIndex)
  }

  func testMaximumWidth() {
    self.collectionView.frame.size.width = 375
    Stubber.register(self.delegate.collectionView(_:layout:marginForSectionAt:)) { _ in
      return UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForSectionAt:)) { _ in
      return UIEdgeInsets(top: 5, left: 6, bottom: 7, right: 8)
    }
    Stubber.register(self.delegate.collectionView(_:layout:marginForItemAt:)) { _ in
      return UIEdgeInsets(top: 9, left: 10, bottom: 11, right: 12)
    }
    Stubber.register(self.delegate.collectionView(_:layout:paddingForItemAt:)) { _ in
      return UIEdgeInsets(top: 13, left: 14, bottom: 15, right: 16)
    }
    XCTAssertEqual(self.layout.maximumWidth(forItemAt: IndexPath(item: 0, section: 0)), 303)
  }

  func testPerformance() {
    measure {
      Stubber.register(self.delegate.collectionView(_:layout:sizeForItemAt:)) { _ in
        return CGSize(width: 50, height: 30)
      }
      self.dataSource(for: BasicSection.self).sections = (0..<100).map { _ in
        BasicSection(items: .init(repeating: .init(), count: 10))
      }
      self.collectionView.collectionViewLayout.prepare()
    }
  }
}
#endif

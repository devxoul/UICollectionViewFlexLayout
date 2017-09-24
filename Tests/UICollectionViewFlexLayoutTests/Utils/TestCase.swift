#if os(iOS)
import XCTest
import Stubber
import UICollectionViewFlexLayout

class TestCase: XCTestCase {
  private(set) var layout: UICollectionViewFlexLayout!
  private(set) var collectionView: UICollectionView!
  private(set) var delegate: LayoutDelegate!

  override func setUp() {
    super.setUp()
    let frame = UIScreen.main.bounds
    self.layout = UICollectionViewFlexLayout()
    self.delegate = LayoutDelegate()
    self.collectionView = UICollectionView(frame: frame, collectionViewLayout: self.layout)
    self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionBackground, withReuseIdentifier: "sectionBackgroundView")
    self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindItemBackground, withReuseIdentifier: "itemBackgroundView")
    self.collectionView.delegate = self.delegate
  }

  override func tearDown() {
    super.tearDown()
    Stubber.clear()
  }

  func dataSource<S: SectionModelType>(for type: S.Type) -> DataSource<S> {
    return DataSource<S>(
      collectionView: self.collectionView,
      cellFactory: { collectionView, indexPath, _ in
        collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      },
      supplementaryViewFactory: { collectionView, kind, indexPath, _ in
        switch kind {
        case UICollectionElementKindSectionBackground:
          return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionBackgroundView", for: indexPath)
        case UICollectionElementKindItemBackground:
          return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "itemBackgroundView", for: indexPath)
        default:
          fatalError()
        }
      }
    )
  }

  func cell(at section: Int, _ item: Int) -> UICollectionViewLayoutAttributes? {
    let indexPath = IndexPath(item: item, section: section)
    return self.layout?.layoutAttributesForItem(at: indexPath)
  }

  func background(at section: Int) -> UICollectionViewLayoutAttributes? {
    let indexPath = IndexPath(item: 0, section: section)
    return self.layout?.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionBackground, at: indexPath)
  }

  func background(at section: Int, _ item: Int) -> UICollectionViewLayoutAttributes? {
    let indexPath = IndexPath(item: item, section: section)
    return self.layout?.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindItemBackground, at: indexPath)
  }
}
#endif

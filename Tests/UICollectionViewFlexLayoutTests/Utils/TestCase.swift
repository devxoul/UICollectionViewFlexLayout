#if os(iOS)
import XCTest
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
    self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionBackground, withReuseIdentifier: "backgroundView")
    self.collectionView.delegate = self.delegate
  }

  override func tearDown() {
    super.tearDown()
  }

  func dataSource<S: SectionModelType>(for type: S.Type) -> DataSource<S> {
    return DataSource<S>(
      collectionView: self.collectionView,
      cellFactory: { collectionView, indexPath, _ in
        collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      },
      supplementaryViewFactory: { collectionView, kind, indexPath, _ in
        collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "backgroundView", for: indexPath)
      }
    )
  }

  func frame(at section: Int, _ item: Int) -> CGRect? {
    let indexPath = IndexPath(item: item, section: section)
    return self.layout?.layoutAttributesForItem(at: indexPath)?.frame
  }

  func background(at section: Int) -> CGRect? {
    let indexPath = IndexPath(item: 0, section: section)
    return self.layout?.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionBackground, at: indexPath)?.frame
  }
}
#endif

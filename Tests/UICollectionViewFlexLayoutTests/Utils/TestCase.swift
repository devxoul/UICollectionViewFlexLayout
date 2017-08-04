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
    self.collectionView.delegate = self.delegate
  }

  override func tearDown() {
    super.tearDown()
  }

  func dataSource<S: SectionModelType>(for type: S.Type) -> DataSource<S> {
    return DataSource<S>(collectionView: self.collectionView) { collectionView, indexPath, _ in
      collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
  }

  func frame(at section: Int, _ item: Int) -> CGRect? {
    let indexPath = IndexPath(item: item, section: section)
    return self.layout?.layoutAttributesForItem(at: indexPath)?.frame
  }
}
#endif

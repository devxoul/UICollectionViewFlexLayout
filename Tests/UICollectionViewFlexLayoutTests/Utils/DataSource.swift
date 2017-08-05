#if os(iOS)
import UIKit
import UICollectionViewFlexLayout

class DataSource<Section: SectionModelType>: NSObject, UICollectionViewDataSource {
  typealias CellFactory = (UICollectionView, IndexPath, Section.Item) -> UICollectionViewCell
  typealias SupplementaryViewFactory = (UICollectionView, String, IndexPath, Section.Item) -> UICollectionReusableView

  private weak var collectionView: UICollectionView?
  private let cellFactory: CellFactory
  private let supplementaryViewFactory: SupplementaryViewFactory

  var sections: [Section] = [] {
    didSet {
      self.collectionView?.reloadData()
      self.collectionView?.layoutIfNeeded()
    }
  }

  subscript(section: Int) -> Section {
    return self.sections[section]
  }

  subscript(indexPath: IndexPath) -> Section.Item {
    return self.sections[indexPath]
  }

  init(collectionView: UICollectionView, cellFactory: @escaping CellFactory, supplementaryViewFactory: @escaping SupplementaryViewFactory) {
    self.collectionView = collectionView
    self.cellFactory = cellFactory
    self.supplementaryViewFactory = supplementaryViewFactory
    super.init()
    collectionView.dataSource = self
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return self.sections.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.sections[section].items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let sectionItem = self.sections[indexPath.section].items[indexPath.item]
    return self.cellFactory(collectionView, indexPath, sectionItem)
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let sectionItem = self.sections[indexPath.section].items[indexPath.item]
    return self.supplementaryViewFactory(collectionView, kind, indexPath, sectionItem)
  }
}
#endif

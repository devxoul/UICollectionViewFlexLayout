#if os(iOS)
import class Foundation.NSObject
import struct Foundation.IndexPath

import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell
import protocol UIKit.UICollectionViewDataSource

class DataSource<Section: SectionModelType>: NSObject, UICollectionViewDataSource {
  typealias CellFactory = (UICollectionView, IndexPath, Section.Item) -> UICollectionViewCell

  private weak var collectionView: UICollectionView?
  private let cellFactory: CellFactory

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

  init(collectionView: UICollectionView, cellFactory: @escaping CellFactory) {
    self.collectionView = collectionView
    self.cellFactory = cellFactory
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
    collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionBackground, withReuseIdentifier: "myBackgroundView", for: indexPath)
  }
}
#endif

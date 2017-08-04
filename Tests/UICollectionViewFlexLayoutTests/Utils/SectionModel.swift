#if os(iOS)
import struct Foundation.IndexPath

protocol SectionModelType {
  associatedtype Item
  var items: [Item] { get }
}

extension Array where Element: SectionModelType {
  subscript(indexPath: IndexPath) -> Element.Item {
    return self[indexPath.section].items[indexPath.item]
  }
}
#endif

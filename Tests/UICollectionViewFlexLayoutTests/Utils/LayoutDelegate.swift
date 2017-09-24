#if os(iOS)
import UIKit
import Stubber
import UICollectionViewFlexLayout

final class LayoutDelegate: NSObject, UICollectionViewDelegateFlexLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return Stubber.invoke(collectionView(_:layout:sizeForItemAt:), args: (collectionView, collectionViewLayout, indexPath), default: .zero)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenSectionAt section: Int, and nextSection: Int) -> CGFloat {
    return Stubber.invoke(collectionView(_:layout:verticalSpacingBetweenSectionAt:and:), args: (collectionView, collectionViewLayout, section, nextSection), default: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForSectionAt section: Int) -> UIEdgeInsets {
    return Stubber.invoke(collectionView(_:layout:marginForSectionAt:), args: (collectionView, collectionViewLayout, section), default: .zero)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForSectionAt section: Int) -> UIEdgeInsets {
    return Stubber.invoke(collectionView(_:layout:paddingForSectionAt:), args: (collectionView, collectionViewLayout, section), default: .zero)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, horizontalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat {
    return Stubber.invoke(collectionView(_:layout:horizontalSpacingBetweenItemAt:and:), args: (collectionView, collectionViewLayout, indexPath, nextIndexPath), default: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat {
    return Stubber.invoke(collectionView(_:layout:verticalSpacingBetweenItemAt:and:), args: (collectionView, collectionViewLayout, indexPath, nextIndexPath), default: 0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForItemAt indexPath: IndexPath) -> UIEdgeInsets {
    return Stubber.invoke(collectionView(_:layout:marginForItemAt:), args: (collectionView, collectionViewLayout, indexPath), default: .zero)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForItemAt indexPath: IndexPath) -> UIEdgeInsets {
    return Stubber.invoke(collectionView(_:layout:paddingForItemAt:), args: (collectionView, collectionViewLayout, indexPath), default: .zero)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, zIndexForItemAt indexPath: IndexPath) -> Int {
    return Stubber.invoke(collectionView(_:layout:zIndexForItemAt:), args: (collectionView, collectionViewLayout, indexPath), default: 0)
  }
}
#endif

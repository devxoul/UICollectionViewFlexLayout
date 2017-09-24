#if os(iOS)
import UIKit

@objc public protocol UICollectionViewDelegateFlexLayout: UICollectionViewDelegate {
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenSectionAt section: Int, and nextSection: Int) -> CGFloat
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForSectionAt section: Int) -> UIEdgeInsets
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForSectionAt section: Int) -> UIEdgeInsets

  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, horizontalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, verticalSpacingBetweenItemAt indexPath: IndexPath, and nextIndexPath: IndexPath) -> CGFloat
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, marginForItemAt indexPath: IndexPath) -> UIEdgeInsets
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, paddingForItemAt indexPath: IndexPath) -> UIEdgeInsets
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  @objc optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlexLayout, zIndexForItemAt indexPath: IndexPath) -> Int
}
#endif

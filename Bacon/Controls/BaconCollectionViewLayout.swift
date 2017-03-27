//
//  Created by Nattapong Unaregul on 4/4/2558 BE.
//  Copyright (c) 2558 Nattapong. All rights reserved.
//

import UIKit
@objc protocol UICollectionViewDelegateTJProductLayout : UICollectionViewDelegate{
    func maximumNumberOfColumnsForCollectionView(collectionView : UICollectionView ,layout : UICollectionViewLayout) -> UInt8
}
enum LayoutBaconCollectionView : Int{
    case OneColumn = 1 , TwoColumn = 2,RowRecords = 3
}
class BaconCollectionViewLayout : UICollectionViewLayout{
    
    //Containers for keeping track of changing items
    var _layoutCellAttributes = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var _layoutSupplementaryAttributesByKind = Dictionary<String, Dictionary<IndexPath,UICollectionViewLayoutAttributes>>()
    var _removedIndexPaths : NSMutableArray?
    var _removedSections : NSMutableArray?
    
    var _spacingTopFloatingInset = 0 as CGFloat
    var _horizontalInset = 8 as CGFloat
    var _verticalInset = 8 as CGFloat
    
    var _itemHeight = 0.0 as CGFloat
    var _itemWidth = 0.0 as CGFloat
    
    var _contentSize = CGSize.zero
    var _column = 2 as UInt8
    var _enumLayout : LayoutBaconCollectionView = .TwoColumn
    //Loding View
    var _showLoading : Bool = false
    let _LoadingViewSize = CGSize(width: UIScreen.main.bounds.width, height: 35)
    override init() {
        super.init()
    }
    init(withLayout:LayoutBaconCollectionView) {
        super.init()
        _enumLayout = withLayout
        if withLayout == .OneColumn || withLayout == .RowRecords{
            _column = 1
            
        }else {
            _column = 2
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func CalculateCellsize(NumberofColumns:UInt8,iwidth :inout CGFloat,  iheight :inout CGFloat){
        
        let NumberOfCoumn_CGFLoat : CGFloat = CGFloat(NumberofColumns)
        let RemainningWidth = self.collectionView!.frame.width - (_horizontalInset * (NumberOfCoumn_CGFLoat)) as CGFloat
        switch (_enumLayout){
        case .OneColumn :
            if UIScreen.main.bounds.height == 568 { //Iphone 5
                iwidth = RemainningWidth - _horizontalInset
                iheight = 405
            }else if UIScreen.main.bounds.height == 736 { //Iphone 6s
                iwidth = RemainningWidth - _horizontalInset
                iheight = 500
            }else if UIScreen.main.bounds.height == 320 {//iphone 4gs
                iwidth = RemainningWidth - _horizontalInset
                iheight = 430
                
            }else{ //Iphone 6
                iwidth = RemainningWidth - _horizontalInset
                iheight = iwidth * 1.30
            }
        case .RowRecords :
            iwidth = RemainningWidth
            iheight = 150
        default : //2
            if UIScreen.main.bounds.height == 568 { //Iphone 5
                iwidth = RemainningWidth / NumberOfCoumn_CGFLoat - _horizontalInset/2
                iheight = 238
            }else if UIScreen.main.bounds.height == 736 { //Iphone 6 plus
                iwidth = RemainningWidth / NumberOfCoumn_CGFLoat - _horizontalInset/2
                iheight = 285
            }else if UIScreen.main.bounds.height == 320 {//iphone 4gs
                iwidth = RemainningWidth / NumberOfCoumn_CGFLoat - _horizontalInset/2
                iheight = 238
                
            }else{ //Iphone 6
                iwidth = RemainningWidth / NumberOfCoumn_CGFLoat - _horizontalInset/2
                iheight = iwidth * 1.52
            }
            
        }
    }
    func baconLayout(NumberofColumns:UInt8 ){
        var LayoutSupplementaryHeaderDictionary  = Dictionary<IndexPath,UICollectionViewLayoutAttributes>()
        if _enumLayout == .OneColumn || _enumLayout == .TwoColumn {
            
        }else{
            _horizontalInset = 0
            _verticalInset = 3 as CGFloat
        }
        CalculateCellsize( NumberofColumns: NumberofColumns, iwidth: &self._itemWidth, iheight: &self._itemHeight)
        let headerHeight = CGFloat(_spacingTopFloatingInset)
        // 2
        let numberOfSections = self.collectionView!.numberOfSections
        var yOffset = _verticalInset
        
        for section in 0...numberOfSections - 1 {
            let path = IndexPath(item: 0, section: section)
            let attributesHeader = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: path)
            attributesHeader.frame = CGRect(x:0, y:0,width: self.collectionView!.frame.size.width,height:headerHeight)
            LayoutSupplementaryHeaderDictionary[path] = attributesHeader
            let numberOfItems = self.collectionView!.numberOfItems(inSection: section)
            var xOffset = _horizontalInset
            for item in 0...numberOfItems - 1 {
                let ItemindexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: ItemindexPath)
                var itemSize = CGSize.zero
                itemSize.width = _itemWidth
                itemSize.height = _itemHeight
                var increaseRow = false
                attributes.center = CGPoint(x:xOffset + (_itemWidth / 2), y:yOffset + (_itemHeight / 2))
                attributes.size = CGSize(width:_itemWidth, height:_itemHeight)
                self._layoutCellAttributes[ItemindexPath] = attributes // 7
                xOffset += itemSize.width
                if(xOffset + self._horizontalInset >= self.collectionView!.frame.width - (self.collectionView!.contentInset.right * 2)){
                    increaseRow = true
                }
                xOffset += self._horizontalInset
                if increaseRow && !(item == numberOfItems - 1 && section == numberOfSections - 1) {
                    yOffset += self._verticalInset
                    yOffset += self._itemHeight
                    xOffset = _horizontalInset
                }
            }
        }
        
        
        self._layoutSupplementaryAttributesByKind[UICollectionElementKindSectionHeader] = LayoutSupplementaryHeaderDictionary
        yOffset += self._itemHeight
        
        if self._showLoading {
            yOffset += self._LoadingViewSize.height
        }
        
        _contentSize = CGSize(width:self.collectionView!.frame.size.width - _horizontalInset
            ,height:yOffset + _verticalInset) // 11
    }
    override func prepare() {
        _layoutCellAttributes.removeAll(keepingCapacity: true)
        _layoutSupplementaryAttributesByKind.removeAll(keepingCapacity: true)
        baconLayout(NumberofColumns: _column)
    }
    
    
    func layoutKeyForIndexPath(indexPath : NSIndexPath) -> String {
        return "\(indexPath.section)_\(indexPath.row)"
    }
    
    func layoutKeyForHeaderAtIndexPath(indexPath : NSIndexPath) -> String {
        return "s_\(indexPath.section)_\(indexPath.row)"
    }
    
    // MARK: -
    // MARK: Invalidate
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds : CGRect = self.collectionView!.bounds
        if oldBounds.equalTo(newBounds){
            return true
        }
        return false
    }
    // MARK: -
    // MARK: Required methods
    
    override var collectionViewContentSize: CGSize {
        return _contentSize
    }
    
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var AnAttribute  : UICollectionViewLayoutAttributes?
        if elementKind == UICollectionElementKindSectionHeader {
            AnAttribute = self._layoutSupplementaryAttributesByKind[elementKind]?[indexPath]
        }else{
            AnAttribute = self._layoutSupplementaryAttributesByKind[elementKind]?[indexPath]
        }
        return AnAttribute
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return _layoutCellAttributes[indexPath]
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var AttibutesArray : [UICollectionViewLayoutAttributes] = []
        for (_,value) in _layoutCellAttributes{
            if rect.intersects(value.frame) {
                AttibutesArray.append(value)
            }
            
            
        }
        for(key,value) in _layoutSupplementaryAttributesByKind{
            
            if key == UICollectionElementKindSectionHeader {
                for(_,value_) in value{
                    if rect.intersects(value_.frame){
                        AttibutesArray.append(value_)
                    }
                }
            }
        }
        
        return AttibutesArray
    }
    override func finalizeAnimatedBoundsChange() {
        super.finalizeAnimatedBoundsChange()
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var rtnProposedContentoffset : CGPoint
        if(proposedContentOffset.y <= _spacingTopFloatingInset){
            rtnProposedContentoffset = CGPoint(x: 0, y: 1)
        }else{
            rtnProposedContentoffset = proposedContentOffset
        }
        return rtnProposedContentoffset
    }
    
}

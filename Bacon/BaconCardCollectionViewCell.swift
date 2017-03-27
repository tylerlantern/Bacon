//
//  BaconCardCollectionViewCell.swift
//  Bacon
//
//  Created by Nattapong Unaregul on 3/18/2560 BE.
//  Copyright © 2560 Nattapong Unaregul. All rights reserved.
//



import UIKit;
class BaconCardCollectionViewCell: UICollectionViewCell {
    var indexPath : NSIndexPath?
    var Thumbnail: UIImageView!
    var ActivityIndicatorView: UIActivityIndicatorView!
    var lb_ProductCode: UILabel!
    var lb_ProductName: UILabel!
    var lb_DisplayNormalPrice: UILabel!
    var lb_DisplayPrice: UILabel!
    var lb_Save : UILabel!
    var lb_kindlyAskForPrice : UILabel!
    var currentLayout : LayoutBaconCollectionView = .RowRecords
    
    var IsSetPosition : Bool = false
    let _HorizontalSpacing = CGFloat(10)
    var UIImage_ShownOnlyOrRenewal : UIImageView!
    var UIImage_Reserved : UIImageView!
    var UIView_bgReserved : UIView!
    var lb_IndexNumber : UILabel!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.layoutIfNeeded()
        self.SetLayoutAccordingToDesiredLayout()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true

        self.ActivityIndicatorView.hidesWhenStopped = true
        SetLayoutAccordingToDesiredLayout()
        
    }
    func SetLayoutAccordingToDesiredLayout(){
        if self.currentLayout == LayoutBaconCollectionView.OneColumn || self.currentLayout == LayoutBaconCollectionView.TwoColumn {
            DoColumnLayout(DesiredLayout: self.currentLayout)
        }else{
            DoRecordLayout()
        }
    }

    func DoRecordLayout(){

    }
    func DoColumnLayout(DesiredLayout : LayoutBaconCollectionView){

    }
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        let nLayout = newLayout as! BaconCollectionViewLayout
        self.currentLayout = nLayout._enumLayout
    }
    override func didTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.Thumbnail.image = nil
    }
    
    
    
    
}

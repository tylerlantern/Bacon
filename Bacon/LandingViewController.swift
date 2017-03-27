//
//  LandingViewController.swift
//  Bacon
//
//  Created by Nattapong Unaregul on 3/5/2560 BE.
//  Copyright © 2560 Nattapong Unaregul. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    var oneColumnLayout : BaconCollectionViewLayout = BaconCollectionViewLayout(withLayout: LayoutBaconCollectionView.OneColumn)
    var twoColumnLayout : BaconCollectionViewLayout = BaconCollectionViewLayout(withLayout: LayoutBaconCollectionView.TwoColumn)
    var recordsLayout : BaconCollectionViewLayout = BaconCollectionViewLayout(withLayout: LayoutBaconCollectionView.RowRecords)
    let reusedCollectionViewCellIdentiier = "baconCollectionViewIdentifier"
    @IBOutlet weak var collectionView: UICollectionView!
    func toggleLayout(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = recordsLayout
        self.collectionView.register(BaconCollectionViewLayout.self, forCellWithReuseIdentifier: reusedCollectionViewCellIdentiier)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cardCell : BaconCardCollectionViewCell?
            = collectionView.dequeueReusableCell(withReuseIdentifier: reusedCollectionViewCellIdentiier, for: indexPath) as? BaconCardCollectionViewCell
        if cardCell == nil {
            cardCell = BaconCardCollectionViewCell(frame: CGRect.zero)
        }
        return cardCell!
    }
}




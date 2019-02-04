//
//  ViewController.swift
//  DayView
//
//  Created by NaveenMagatala on 01/31/2019.
//  Copyright (c) 2019 NaveenMagatala. All rights reserved.
//

import UIKit
import DayView

class ViewController: UIViewController {

    @IBOutlet weak var dayView: DayView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dayView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: DayViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("ended displaying")
    }
}


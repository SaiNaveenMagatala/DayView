//
//  CollectionViewCell.swift
//  DayView
//
//  Created by Naveen Magatala on 1/31/19.
//

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        background.layer.cornerRadius = background.frame.height/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.backgroundColor = .clear
    }
}

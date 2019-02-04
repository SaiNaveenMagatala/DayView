//
//  DayView.swift
//  DayView
//
//  Created by Naveen Magatala on 1/31/19.
//

public protocol DayViewDelegate: UICollectionViewDelegate { }

open class DayView: UIView, NibLoadable {
    
    @IBOutlet weak public var collectionView: UICollectionView!
    @IBOutlet weak public var headerDate: UILabel!
    
    public weak var delegate: DayViewDelegate?
    
    lazy var dateController = DateController.shared
    
    var twentyOneDays: [Date] {
        return dateController.twentyOnedays
    }
    
    var selectedIndexPath: IndexPath?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        collectionView.isPagingEnabled = true
        let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle(for: type(of: self)))
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        setupCollectionViewInitialPosition()
    }
    
    func setupCollectionViewInitialPosition() {
        let firstDayOfWeek = dateController.getFirstDayOfWeek()
        let today = dateController.todayDate
        
        if let scrollItem = twentyOneDays.index(of: firstDayOfWeek) {
            let scrollIndexpath = IndexPath(row: scrollItem, section: 0)
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.scrollToItem(at: scrollIndexpath, at: .left, animated: true)
            }
        }
        
        if let selectionRow = twentyOneDays.index(of: today) {
            let selectionIndexpath = IndexPath(row: selectionRow, section: 0)
            highlightSelectedCell(selectionIndexpath)
        }
    }
}

extension DayView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return twentyOneDays.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                            for: indexPath) as? CollectionViewCell
            else { fatalError("CollectionViewCell") }
        cell.dayLabel.text = twentyOneDays[indexPath.row].shortday
        cell.background.backgroundColor = indexPath == selectedIndexPath ? .lightGray : .clear
        return cell
    }
}

extension DayView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
        if indexPath.row == twentyOneDays.count - 6 {
            dateController.fetchNextWeek()
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        
        delegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        highlightSelectedCell(indexPath)
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    func highlightSelectedCell(_ indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
        headerDate.text = twentyOneDays[indexPath.row].detailedDate
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        if offsetX < 0 {
            let beforeContentSize = collectionView.contentSize
            dateController.fetchPastWeek()
            collectionView.reloadData()
            selectedIndexPath = nil
            
            let afterContentSize = collectionView.collectionViewLayout.collectionViewContentSize
            let afterContentOffset = collectionView.contentOffset
            
            let newContentOffset = CGPoint(x: afterContentOffset.x + afterContentSize.width - beforeContentSize.width,
                                           y: afterContentOffset.y)
            collectionView.contentOffset = newContentOffset
        }
        
        delegate?.scrollViewDidScroll?(scrollView)
    }
}

extension DayView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/7,
                      height: collectionView.frame.height)
    }
}

extension DayView {
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
}


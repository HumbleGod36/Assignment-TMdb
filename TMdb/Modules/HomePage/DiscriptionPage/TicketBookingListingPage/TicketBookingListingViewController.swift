//
//  TicketBookingListingViewController.swift
//  TMdb
//
//  Created by Tony Michael on 02/03/24.
//

import UIKit

class TicketBookingListingViewController: UIViewController {
    
    var movieName : String?
    var movieDate : String?
    
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var DateCollectionView: UICollectionView!
    @IBOutlet weak var screenCollectionView: UICollectionView!
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func selectSeatsButtonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "BookSeatsViewController") as! BookSeatsViewController
        vc.mName = movieName
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieDateLabel.text = movieDate
        self.movieNameLabel.text = movieName
        
        DateCollectionView.register(UINib(nibName: "BookingDatesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookingDatesCollectionViewCell")
        DateCollectionView.delegate = self
        DateCollectionView.dataSource = self
        
        screenCollectionView.register(UINib(nibName: "ScreensCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreensCollectionViewCell")
        screenCollectionView.delegate = self
        screenCollectionView.dataSource = self
    }
    
}
extension TicketBookingListingViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == DateCollectionView {
            return 10 }
        else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == DateCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingDatesCollectionViewCell", for: indexPath) as! BookingDatesCollectionViewCell
//        cell.selectedBackgroundView =  cell.dateBackGroundView
//            cell.selectedBackgroundView?.backgroundColor = UIColor.white
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreensCollectionViewCell", for: indexPath)as! ScreensCollectionViewCell
            cell.screenImage.image = UIImage(named: "Screen Listing")
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == DateCollectionView {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width - 20 ) / 5.5
            
            return CGSize(width: width, height: height)
        } else {
            let height = collectionView.frame.height
            let width = (collectionView.frame.width  ) / 1.5
            
            return CGSize(width: width, height: height)
        }
        
    }
       // Your existing collection view methods...
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if collectionView == DateCollectionView {
               var selectedIndexPath: IndexPath?
            
               if let selectedIndexPath = selectedIndexPath {
                   let previousSelectedCell = collectionView.cellForItem(at: selectedIndexPath) as? BookingDatesCollectionViewCell
                   previousSelectedCell?.dateBackGroundView.backgroundColor = UIColor.lightGray
               }
               
               selectedIndexPath = indexPath
 
               let cell = collectionView.cellForItem(at: indexPath) as? BookingDatesCollectionViewCell
               cell?.dateBackGroundView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
           }
       }
    
}

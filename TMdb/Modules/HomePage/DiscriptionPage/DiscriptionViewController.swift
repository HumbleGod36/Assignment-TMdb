//
//  DiscriptionViewController.swift
//  TMdb
//
//  Created by Tony Michael on 29/02/24.
//

import UIKit
import Alamofire

class DiscriptionViewController: UIViewController {
    
    var movieId : Int?
    var movieDetails : MovieDiscriptionModel?
    
    // Converting date formate
    var dateFormate : DateFormatter {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMMM d, yyyy"
        return dateFormate
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var dateToBeReleased: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    @IBAction func errorBackButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func watchTrailerButtonClicked(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        vc.youtubeId  = movieId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func bookYourTicketsButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "TicketBookingListingViewController") as! TicketBookingListingViewController
        vc.modalPresentationStyle = .fullScreen
        vc.movieName =  movieDetails?.originalTitle
        vc.movieDate = getFormatedDate(inputDate: movieDetails?.releaseDate ?? "", outputDateFormat: dateFormate)
        self.present(vc, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetailsData()
        customizeButtonAppearance()
        loaderView.isHidden = false
        errorMessage.isHidden = true
    }
    
    // registering genres Cell
    func registeringCollectionVIew(){
        genreCollectionView.register(UINib(nibName: "DiscGenresCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DiscGenresCollectionViewCell")
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    // Data from Api
    func fetchMovieDetailsData() {
        let url = AppStrings.baseUrl + "\(movieId ?? 0)"
        print(url)
        let headers :HTTPHeaders = [.authorization(bearerToken: AppStrings.authToken)]
        
        AF.request(url,method: .get,encoding: JSONEncoding.default,headers: headers).responseDecodable (of:MovieDiscriptionModel.self) { response in
            switch response.result {
            case.success(let object):
                print(object)
                self.loaderView.isHidden = true
                self.movieDetails = object
                self.updateUIWithMovieDetails()
                self.registeringCollectionVIew()
            case.failure(let error):
                print(error)
                self.loaderView.isHidden = false
                self.errorMessage.isHidden = false
                self.errorMessage.text =  AppStrings.errorMessage
                self.activityIndicator.isHidden = true
            }
        }
    }

    
    func updateUIWithMovieDetails(){
        movieImage.sd_setImage(with: URL(string: AppStrings.imageBaseURL + (movieDetails?.backdropPath ?? "")))
        movieName.text = movieDetails?.originalTitle
        dateToBeReleased.text = getFormatedDate(inputDate: movieDetails?.releaseDate ?? "", outputDateFormat: dateFormate)

        movieOverView.text = movieDetails?.overview ?? ""
    }
    
    func customizeButtonAppearance(){
        watchTrailerButton.layer.cornerRadius = 12
        watchTrailerButton.layer.borderColor = UIColor.white.cgColor
        watchTrailerButton.layer.borderWidth = 1
        watchTrailerButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
  
}
extension DiscriptionViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movieDetails?.genres.count ?? 0)
        return movieDetails?.genres.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscGenresCollectionViewCell", for: indexPath) as! DiscGenresCollectionViewCell
        cell.genresBackgroundView.backgroundColor =  UIColor.random()
        cell.genresLabel.text = movieDetails?.genres[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 6
        let height = collectionView.frame.height
        return CGSizeMake(width, height)
    }
    
    
}

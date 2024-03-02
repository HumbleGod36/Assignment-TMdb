import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {
    
     let tableViewCellIdentifier = "TableViewCell"
     var moviesDataList: HomePageModel?
    
    @IBOutlet  weak var errorLabel: UILabel!
    @IBOutlet  weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet  weak var mainView: UIView!
    @IBOutlet  weak var loaderView: UIView!
    @IBOutlet  weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchUpcomingMoviesData()
        
       
    }
    
    func setupViews() {
        mainView.isHidden = true
        loaderView.isHidden = false
        errorLabel.isHidden = true
        
        tableView.register(UINib(nibName: tableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
      // Data from Api (Upcoming Movies)
     func fetchUpcomingMoviesData() {
        let url = AppStrings.baseUrl + AppStrings.movieListUrl
        let headers: HTTPHeaders = [.authorization(bearerToken: AppStrings.authToken)]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: HomePageModel.self) { response in
                switch response.result {
                case .success(let object):
                    self.moviesDataList = object
                    self.tableView.reloadData()
                    self.mainView.isHidden = false
                    self.loaderView.isHidden = true
                case .failure(let error):
                    print("Error fetching popular movies: \(error)")
                    self.mainView.isHidden = true
                    self.activityIndicator.isHidden = true
                    self.errorLabel.isHidden = false
                }
            }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesDataList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath ) as? TableViewCell else {
            return UITableViewCell()
        }
        
        if let movie = moviesDataList?.results[indexPath.row] {
            cell.movieName.text = movie.originalTitle
            cell.movieImage.sd_setImage(with: URL(string: AppStrings.imageBaseURL + movie.backdropPath))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = moviesDataList?.results[indexPath.row].id else {
            return
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "DiscriptionViewController") as! DiscriptionViewController
        vc.movieId = movieId
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

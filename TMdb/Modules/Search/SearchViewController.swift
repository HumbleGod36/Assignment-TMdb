//
//  SearchViewController.swift
//  TMdb
//
//  Created by Tony Michael on 01/03/24.
//

import UIKit
import Alamofire
import SDWebImage

class SearchViewController: UIViewController {
    var searchDataList : SearchModel?
    var genreDataList : GenreModel?
    
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var searchedView: UIView!
    @IBOutlet weak var searchResult: UILabel!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        headerText.isHidden = false
        searchedView.isHidden = true
        searchTextField.text = ""
        searchTextField.isHidden = false
        addingRightButtonToTextField(systemName: "magnifyingglass")
        addingLeftButtonToTextField(systemName: "")
        searchTableView.isHidden = true
        fetchGenreData()
        genreCollectionView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGenreData()
        
        searchTableView.isHidden = true
        genreCollectionView.isHidden = false
        
        addingRightButtonToTextField(systemName: "magnifyingglass")
        addingLeftButtonToTextField(systemName: "")
        
        searchedView.isHidden = true
        searchTextField.isHidden = false
        
        registeringCells()
        textFieldStyling(textField: searchTextField)

    }
    
    // registering Tableview and collectionViewCells
    
    func registeringCells(){
        genreCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    // search button and X button inside text field
    func addingRightButtonToTextField(systemName : String){
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(UIImage(systemName: systemName ), for: .normal)
        button.sizeToFit()
        button.tintColor = .gray
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        paddingView.addSubview(button)
        searchTextField.rightView  = paddingView
        searchTextField.rightViewMode = .always
        button.sizeToFit()
        button.addTarget(self, action: #selector(self.XButtonCicked(_:)), for: .touchUpInside)
    }
    
    @objc func XButtonCicked(_ sender : UIButton){
        searchTextField.text = ""
    }
    // search Search button inside text field
    
    func addingLeftButtonToTextField(systemName : String) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        paddingView.addSubview(button)
        
        button.frame = CGRect(x: 20, y: 0, width: 20, height: 20)

        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
    }
    
    // Api Call foor Genre Data
    
    func fetchGenreData(){
        let url =  AppStrings.genresUrl
        print (url)
        let headers: HTTPHeaders = [.authorization(bearerToken: AppStrings.authToken)]
        
        AF.request(url,method: .get , encoding: JSONEncoding.default , headers: headers).responseDecodable(of: GenreModel.self) { response in
            switch response.result {
            case.success(let object):
                print(object)
                self.genreDataList = object
                self.genreCollectionView.reloadData()
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchingSearchData(){
        let url = AppStrings.searchBaseUrl + (searchTextField.text ?? "") + AppStrings.searchAdditionUrl
      //  print(url)
        let headers :HTTPHeaders = [.authorization(bearerToken: AppStrings.authToken)]
        AF.request(url,method: .get,encoding: JSONEncoding.default, headers: headers ).responseDecodable (of: SearchModel.self) { response in
            switch response.result{
            case .success(let data):
     //          print(data)
                self.searchDataList = data
                self.searchTableView.reloadData()
            case.failure(let error):
                print(error)
                
            }
        }
    }
    
//    func gettingGenreName()  {
//        let genreId =  searchDataList?.results.map{$0.id}
//    }
//    
//        func getGenreNameById(_ id: Int) -> String? {
//            if let genre = searchDataList?.results.first(where: { $0.genreIDS == id }) {
//                   return genre.name
//               } else {
//                   return nil
//               }
//           }
        
        
    
    
}
extension SearchViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchTextField.isHidden = true
        searchedView.isHidden = false
        searchResult.text = "\(searchDataList?.results.count ?? 0) Result Found"
        headerText.isHidden = true
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.isHidden = true
        searchedView.isHidden = false
        searchResult.text = "\(searchDataList?.results.count ?? 0) Result Found"
        headerText.isHidden = true
        self.view.endEditing(true)
    }
}
extension SearchViewController : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreDataList?.genres.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreLabel.text = genreDataList?.genres[indexPath.row].name
        // Adding a placeHolder Image , as in Api there are no images
        cell.genreImage.sd_setImage(with: URL(string: "https://i.ibb.co/rfHdYGk/cat-han-W-5-Eakb1598-unsplash.jpg"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height - 10) / 4
        let width = (collectionView.frame.width - 20) / 2
        
        return CGSize(width: width, height: height)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTextField {
            addingRightButtonToTextField(systemName: "xmark")
            addingLeftButtonToTextField(systemName: "magnifyingglass")
            fetchingSearchData()
            searchTableView.reloadData()
            searchTableView.isHidden = false
            genreCollectionView.isHidden = true
        }
        return true
    }
    
    // getting genre name from id
    func getGenreNameById(_ id: Int) -> String? {
          if let genre = genreDataList?.genres.first(where: { $0.id == id }) {
              return genre.name
          } else {
              return nil
          }
      }
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Results"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchDataList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.movieName.text = searchDataList?.results[indexPath.row].originalTitle
   
        let genreIDS = searchDataList?.results[indexPath.row].genreIDS ?? []
       
         
        if !genreIDS.isEmpty {
            let genreId = genreIDS[0]
            cell.movieGenre.text = getGenreNameById(genreId)
        } else {
            print("out of index")
        }
      
        
        
        
        cell.movieImage.sd_setImage(with: URL(string:AppStrings.imageBaseURL + (searchDataList?.results[indexPath.row].posterPath ?? "")))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DiscriptionViewController") as! DiscriptionViewController
        vc.movieId = searchDataList?.results[indexPath.row].id ?? 0
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

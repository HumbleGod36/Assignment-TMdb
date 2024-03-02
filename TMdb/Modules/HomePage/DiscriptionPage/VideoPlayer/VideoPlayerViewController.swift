//
//  VideoPlayerViewController.swift
//  TMdb
//
//  Created by Tony Michael on 29/02/24.
//

import UIKit
import YouTubePlayer
import Alamofire
import SDWebImage
import Dispatch

class VideoPlayerViewController: UIViewController {
    
    var youtubeId : Int?
    var videosListData : VideoModel?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var youtuberPlayerView: YouTubePlayerView!
    
    @IBAction func doneClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtuberPlayerView.delegate = self
        
        fetchYouTubeVideoData()
        
        mainView.isHidden = true
        loaderView.isHidden = false
    }
    
    func fetchYouTubeVideoData() {
        
        let url =  AppStrings.baseUrl + "\(youtubeId ?? 0 )" + AppStrings.videoLanguageUrl
        let headers: HTTPHeaders = [.authorization(bearerToken: AppStrings.authToken)]
        
        AF.request(url,method: .get , encoding: JSONEncoding.default , headers: headers).responseDecodable(of: VideoModel.self) { response in
            switch response.result {
            case.success(let object):
     //           print(object)
                self.videosListData = object
                self.mainView.isHidden = false
                self.loaderView.isHidden = true
                self.loadYoutubeVideoIntoPlayer()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func loadYoutubeVideoIntoPlayer(){
        let videoKey = self.videosListData?.results?.first.map {$0.key}
        youtuberPlayerView.loadVideoID(videoKey ?? "")
    }

}
extension VideoPlayerViewController : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.youtuberPlayerView.play()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == .Ended {
            self.dismiss(animated: true)
        }
    }
    
    
    
}

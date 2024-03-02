//
//  BookSeatsViewController.swift
//  TMdb
//
//  Created by Tony Michael on 02/03/24.
//

import UIKit

class BookSeatsViewController: UIViewController {

    var mName : String?
   
    @IBOutlet weak var totalPriceView: UIView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var zoomInButton: UIButton!
    @IBOutlet weak var zoomOutButton: UIButton!
    
    @IBAction func BackButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        movieName.text = mName
        
        ButtonShadow(button: zoomInButton)
        ButtonShadow(button: zoomOutButton)
        viewShadow(View: selectedView)
        viewShadow(View: totalPriceView)
        totalPriceView.layer.borderColor = UIColor.lightGray.cgColor
        totalPriceView.layer.borderWidth = 0.3
    }
    
  
 

}

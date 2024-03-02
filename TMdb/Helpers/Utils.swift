//
//  Utils.swift
//  TMdb
//
//  Created by Tony Michael on 01/03/24.
//

import Foundation
import UIKit


    
func getFormatedDate( inputDate : String , outputDateFormat : DateFormatter) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = dateFormatter.date(from: inputDate) {
        let formattedDate =  outputDateFormat.string(from: date)
       
        return formattedDate
    } else {
        return ""
        
    }
    
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
func ButtonShadow(button: UIButton){
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.shadowOpacity = 1.0
    button.layer.shadowRadius = 0.0
    button.layer.masksToBounds = false
}

func viewShadow(View: UIView){
    View.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    View.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    View.layer.shadowOpacity = 1.0
    View.layer.shadowRadius = 0.0
    View.layer.masksToBounds = false
}

func textFieldStyling(textField : UITextField) {
    textField.borderStyle = .none
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.borderWidth = 2
    textField.layer.cornerRadius = 24
    textField.tintColor = .cyan
}



//
//  CardItemViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 28.03.25.
//

import UIKit

class CardItemViewController: UIViewController {
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    @IBOutlet weak var expiryDataTexField: UITextField!
    @IBOutlet weak var useThisCard: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useThisCard.layer.cornerRadius = 12
        
    }
    
    @IBAction func useThisCardFunc(_ sender: UIButton) {
        guard let cardNum = cardNumber.text, !cardNum.isEmpty,
                  let nameOnCard = nameOnCardTextField.text, !nameOnCard.isEmpty,
                  let cvc = cvcTextField.text, !cvc.isEmpty,
              let expiryDate = expiryDataTexField.text, !expiryDate.isEmpty else {
            showAlert(message: "Zəhmət olmasa, bütün sahələri doldurun.")
            return
        }
            let cardInfo: [String: String] = [
                "cardNumber": cardNum,
                "nameOnCard": nameOnCard,
                "cvc": cvc,
                "expiryDate": expiryDate
            ]
            showAlert(message:"Kart məlumatlarınız dogrudur, davam etmek isteyirsiniz?")
        }
    
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Davam et", style: .default, handler: nil))
           self.present(alert, animated: true)
       }
}

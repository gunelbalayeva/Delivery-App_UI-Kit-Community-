//
//  ViewController.swift
//  Delivery App_UI Kit (Community)
//
//  Created by User on 21.03.25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var squareView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnView.layer.cornerRadius = 30
        squareView.layer.cornerRadius = 60
        button.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }


    @IBAction func orderNowButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController{
            newViewController.modalPresentationStyle = .fullScreen
            present(newViewController, animated: true)
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        
    }
    
}


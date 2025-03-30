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
    }


    @IBAction func orderNowButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newViewController = storyboard.instantiateViewController(withIdentifier: TabBarController.identifier) as? TabBarController {
            newViewController.modalPresentationStyle = .fullScreen

            let transition = CATransition()
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromRight
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            view.window?.layer.add(transition, forKey: kCATransition)
            present(newViewController, animated: false)
        }

    }
    
    @IBAction func dismissButton(_ sender: Any) {
        let transition = CATransition()
           transition.duration = 0.5
           transition.type = .fade
           transition.subtype = .fromLeft
           view.window?.layer.add(transition, forKey: kCATransition)
           self.dismiss(animated: false, completion: nil)   
    }
    
}


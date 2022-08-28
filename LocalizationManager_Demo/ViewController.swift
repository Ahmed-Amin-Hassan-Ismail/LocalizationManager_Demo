//
//  ViewController.swift
//  LocalizationManager_Demo
//
//  Created by Ahmed Amin on 28/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    

    //MARK: - IBActions
    @IBAction func switchLanguageAction(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myLabel.text = "Language Check"
        myImage.image = UIImage(named: "arrow")
    }


}


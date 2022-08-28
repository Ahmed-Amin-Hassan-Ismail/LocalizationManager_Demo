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
        if LocalizationManager.shared.getLanguage() == .Arabic {
            LocalizationManager.shared.setLanguage(language: .English)
        } else {
            LocalizationManager.shared.setLanguage(language: .Arabic)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myLabel.text = "Language Check".localized
        myImage.image = UIImage(named: "arrow")?.imageFlippedForRightToLeftLayoutDirection()
    }

}


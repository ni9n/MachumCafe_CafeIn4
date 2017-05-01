//
//  MainViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sideBarShowButtonAction(_ sender: Any) {
        let mainViewStoryboard = UIStoryboard(name: "MainView", bundle: nil)
        let sideBarViewController = mainViewStoryboard.instantiateViewController(withIdentifier: "SideBar")
        
        present(sideBarViewController, animated: false, completion: nil)
    }

    @IBAction func tempShowListButtonAction(_ sender: Any) {
        let listContainerViewStoryboard = UIStoryboard(name: "ListContainerView", bundle: nil)
        let listContainerViewController = listContainerViewStoryboard.instantiateViewController(withIdentifier: "ListContainer")
        
        navigationController?.pushViewController(listContainerViewController, animated: true)
    }
}
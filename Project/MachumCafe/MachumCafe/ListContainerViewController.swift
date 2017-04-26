//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit

class ListContainerViewController: UIViewController {
    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    var isMapView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listMapView.removeFromSuperview()
        self.navigationItem.title = "맞춤카페 목록"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func listViewSwitchToggleButtonAction(_ sender: Any) {
        if isMapView {
            view.addSubview(listView)
            listMapView.removeFromSuperview()
        } else {
            view.addSubview(listMapView)
            listView.removeFromSuperview()
        }
        isMapView = !isMapView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
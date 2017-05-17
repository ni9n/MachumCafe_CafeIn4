//
//  ListContainerViewController.swift
//  MachumCafe
//
//  Created by Febrix on 2017. 4. 25..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import UIKit


class ListContainerViewController: UIViewController, SavedFilterDelegate {
    let listViewStoryboard = UIStoryboard(name: "ListView", bundle: nil)
    let listMapViewStoryboard = UIStoryboard(name: "ListMapView", bundle: nil)
    var listTableViewController = UIViewController()
    var listMapViewController = UIViewController()
    var isMapView = false
    var filterArray = [String]()

    @IBOutlet weak var listMapView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var viewSwitchButtonItem: UIBarButtonItem!
    
    func savedFilter(SavedFilter pickedFilter: [String?]) {
        filterArray = [String]()
        let _ = pickedFilter.map { (filter) in
            filterArray.append(filter!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "맞춤카페 목록"
        listMapView.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        listTableViewController = listViewStoryboard.instantiateViewController(withIdentifier: "ListView")
        listMapViewController = listMapViewStoryboard.instantiateViewController(withIdentifier: "ListMap")
        
        NetworkCafe.getCafeList(coordinate: Location.sharedInstance.currentLocation) { (modelCafe) in
            for cafe in modelCafe {
                let isCafe = Cafe.sharedInstance.cafeList.filter({ (cafeList) -> Bool in
                    return cafeList.getCafe()["id"] as! String == cafe.getCafe()["id"] as! String
                })
                if isCafe.isEmpty {
                    Cafe.sharedInstance.cafeList.append(cafe)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
        }
        print("filterArray 1 : ", filterArray)
//        dump(Cafe.sharedInstance.filterCafeList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("filterArray 2 : ", filterArray)
        cafeFilter(filterArray: filterArray)
        //dump(Cafe.sharedInstance.filterCafeList)
        print(Cafe.sharedInstance.filterCafeList.count)
    }
    
    @IBAction func listViewSwitchToggleButtonAction(_ sender: Any) {
        viewSwitchButtonItem.image = isMapView ? #imageLiteral(resourceName: "map_Bt") : #imageLiteral(resourceName: "list_Bt")
        
        let newController = isMapView ? listTableViewController : listMapViewController
        let oldController = childViewControllers.last
        
        oldController?.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = (oldController?.view.frame)!
        transition(from: oldController!, to: newController, duration: 0.3, options: isMapView ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: {
        }) { _ in
            oldController?.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
        }
        isMapView = !isMapView
    }

    @IBAction func showFilterViewButtonItem(_ sender: Any) {
        let filterStoryboard = UIStoryboard(name: "FilterView", bundle: nil)
        let filterViewController = filterStoryboard.instantiateViewController(withIdentifier: "FilterView") as! FilterViewController
        let navigationVC = UINavigationController(rootViewController: filterViewController)
        filterViewController.delegate = self
        present(navigationVC, animated: false, completion: nil)
    }
    
    func cafeFilter(filterArray: [String]) {
        Cafe.sharedInstance.filterCafeList = [ModelCafe]()
        let cafeList = Cafe.sharedInstance.cafeList
        let _ = cafeList.map { (cafe) in
            var result = [String]()
            for category in cafe.getCafe()["category"] as! [String] {
//                print("IN category", category)
                for filter in filterArray {
//                    print("INNE filter", filter)
                    if category == filter {
                        result.append(filter)
//                        print("INNER result", result)
                    }
                }
            }
            if result.sorted() == filterArray.sorted() {
                Cafe.sharedInstance.filterCafeList.append(cafe)
            }
        }
    }
}

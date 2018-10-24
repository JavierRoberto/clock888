//
//  TabBarController.swift
//  8:88
//
//  Created by Javier Roberto on 25/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let resultVC = ResultVC()
        let bestVC = BestResultVC()
        
        resultVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.downloads, tag: 0)
        bestVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.downloads, tag: 1)
        
        viewControllers = [resultVC, bestVC]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

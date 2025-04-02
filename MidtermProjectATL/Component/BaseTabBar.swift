//
//  BaseTabBar.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BaseTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .black
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.barStyle = .black
        tabBar.itemPositioning = .centered
        
        
        
        
    }

}
